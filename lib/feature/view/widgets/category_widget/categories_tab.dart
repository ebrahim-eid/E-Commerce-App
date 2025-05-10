import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/controller/category_cubit/category_cubit.dart';
import 'package:ecommerce_app/feature/controller/sub_category_cubit/sub_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  int? selectedCategoryIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Insets.s16,
        right: Insets.s16,
        top: Insets.s40,
        bottom: Insets.s10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: getBoldStyle(
              color: ColorManager.primary,
              fontSize: FontSize.s24,
            ),
          ),
          SizedBox(height: Sizes.s20),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoriesError) {
                return Center(child: Text(state.message));
              } else if (state is CategoriesLoaded) {
                final categories = state.categories;
                return SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategoryIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedCategoryIndex = index);
                          context.read<SubCategoryCubit>().fetchSubCategoriesByCategory(category.id);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? ColorManager.primary.withOpacity(0.15) : ColorManager.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? ColorManager.primary : ColorManager.primary.withOpacity(0.1),
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: [
                              if (isSelected)
                                BoxShadow(
                                  color: ColorManager.primary.withOpacity(0.08),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: category.image.isNotEmpty
                                    ? Image.network(
                                        category.image,
                                        width: 56,
                                        height: 56,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 40),
                                      )
                                    : Icon(Icons.image, size: 40, color: ColorManager.primary.withOpacity(0.3)),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                width: 80,
                                child: Text(
                                  category.name,
                                  style: getMediumStyle(
                                    color: isSelected ? ColorManager.primary : ColorManager.primary.withOpacity(0.7),
                                    fontSize: FontSize.s14,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          SizedBox(height: Sizes.s24),
          Text(
            'Subcategories',
            style: getBoldStyle(
              color: ColorManager.primary,
              fontSize: FontSize.s20,
            ),
          ),
          SizedBox(height: Sizes.s12),
          Expanded(
            child: BlocBuilder<SubCategoryCubit, SubCategoryState>(
              builder: (context, subState) {
                if (subState is SubCategoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (subState is SubCategoryError) {
                  return Center(child: Text(subState.error));
                } else if (subState is SubCategorySuccess) {
                  final subCategories = subState.subCategories;
                  if (subCategories.isEmpty) {
                    return Center(child: Text('No subcategories found'));
                  }
                  return ListView.separated(
                    itemCount: subCategories.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          subCategories[index].name,
                          style: getRegularStyle(color: ColorManager.primary),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
} 