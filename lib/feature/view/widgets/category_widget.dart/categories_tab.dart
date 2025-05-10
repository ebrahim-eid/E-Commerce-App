import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/controller/category_cubit/category_cubit.dart';
import 'package:ecommerce_app/feature/controller/product_cubit/product_cubit.dart';
import 'package:ecommerce_app/feature/controller/product_cubit/product_states.dart';
import 'package:ecommerce_app/feature/controller/sub_category_cubit/sub_category_cubit.dart';
import 'package:ecommerce_app/feature/model/all_products_model/all_products_model.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/feature/controller/wishlist_cubit/get_wishlist_cubit.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  int? selectedCategoryIndex;
  String? selectedSubcategoryId;

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
                  height: 130,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategoryIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategoryIndex = index;
                            selectedSubcategoryId = null; // Reset selected subcategory
                          });
                          context.read<SubCategoryCubit>().fetchSubCategoriesByCategory(category.id);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: category.image.isNotEmpty
                                    ? Image.network(
                                        category.image,
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 32),
                                      )
                                    : Icon(Icons.image, size: 32, color: ColorManager.primary.withOpacity(0.3)),
                              ),
                              SizedBox(height: 6),
                              SizedBox(
                                width: 80,
                                child: Text(
                                  category.name,
                                  style: getMediumStyle(
                                    color: isSelected ? ColorManager.primary : ColorManager.primary.withOpacity(0.7),
                                    fontSize: FontSize.s12,
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
            child: Column(
              children: [
                Expanded(
                  flex: 1,
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
                            final subCategory = subCategories[index];
                            final isSelected = selectedSubcategoryId == subCategory.id;
                            return ListTile(
                              selected: isSelected,
                              selectedTileColor: ColorManager.primary.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              onTap: () {
                                setState(() => selectedSubcategoryId = subCategory.id);
                                context.read<ProductCubit>().getProductsBySubcategory(subCategory.id);
                              },
                              title: Text(
                                subCategory.name,
                                style: getRegularStyle(
                                  color: isSelected ? ColorManager.primary : ColorManager.primary.withOpacity(0.7),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                if (selectedSubcategoryId != null) ...[
                  SizedBox(height: Sizes.s16),
                  Text(
                    'Products',
                    style: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: FontSize.s20,
                    ),
                  ),
                  SizedBox(height: Sizes.s12),
                  Expanded(
                    flex: 2,
                    child: BlocBuilder<ProductCubit, ProductStates>(
                      builder: (context, state) {
                        if (state is ProductsBySubcategoryLoadingState) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is ProductsBySubcategorySuccessState) {
                          final allProducts = context.read<ProductCubit>().productsBySubcategory?.data ?? [];
                          final filteredProducts = allProducts.where((product) {
                            final subcategories = product.subcategory;
                            if (subcategories is List) {
                              return subcategories.any((sub) =>
                                sub is SubcategoryModel && sub.sId == selectedSubcategoryId
                              );
                            }
                            return false;
                          }).toList();
                          if (filteredProducts.isEmpty) {
                            return Center(child: Text('No products found'));
                          }
                          return BlocBuilder<GetWishlistCubit, GetWishlistState>(
                            builder: (context, wishlistState) {
                              final wishlistIds = wishlistState is GetWishlistLoaded
                                  ? wishlistState.wishlist.map((w) => w.id).toSet()
                                  : <String>{};
                              return GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 7 / 9,
                                ),
                                itemCount: filteredProducts.length,
                                itemBuilder: (context, index) {
                                  final product = filteredProducts[index];
                                  final isInWishlist = wishlistIds.contains(product.id);
                                  return ProductItem(
                                    productId: product.id,
                                    title: product.title,
                                    price: product.price.toDouble(),
                                    image: product.imageCover,
                                    rating: product.ratingsAverage,
                                    isInWishlist: isInWishlist,
                                  );
                                },
                              );
                            },
                          );
                        } else if (state is ProductsBySubcategoryErrorState) {
                          return Center(child: Text(state.error));
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
