import 'package:ecommerce_app/core/images/images_path.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/controller/category_cubit/category_cubit.dart';
import 'package:ecommerce_app/feature/controller/sub_category_cubit/sub_category_cubit.dart';
import 'package:ecommerce_app/feature/view/widgets/category_widget.dart/category_card_item.dart';
import 'package:ecommerce_app/feature/view/widgets/sub_category_widget/sub_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoriesList extends StatelessWidget {
  const SubCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, categoryState) {
          if (categoryState is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (categoryState is CategoriesLoaded && categoryState.categories.isNotEmpty) {
            final selectedCategory = categoryState.categories[0]; // You might want to get this from a state management solution
            return BlocBuilder<SubCategoryCubit, SubCategoryState>(
              builder: (context, subCategoryState) {
                if (subCategoryState is SubCategoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (subCategoryState is SubCategorySuccess) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Text(
                          selectedCategory.name,
                          style: getBoldStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: CategoryCardItem(
                          selectedCategory.name,
                          selectedCategory.image,
                        ),
                      ),
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          childCount: subCategoryState.subCategories.length,
                          (_, index) => SubCategoryItem(
                            subCategoryState.subCategories[index].name,
                            subCategoryState.subCategories[index].image,
                          ),
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.75,
                          mainAxisSpacing: Sizes.s8,
                          crossAxisSpacing: Sizes.s8,
                        ),
                      ),
                    ],
                  );
                } else if (subCategoryState is SubCategoryError) {
                  return Center(child: Text(subCategoryState.error));
                }
                return const SizedBox();
              },
            );
          } else if (categoryState is CategoriesError) {
            return Center(child: Text(categoryState.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
