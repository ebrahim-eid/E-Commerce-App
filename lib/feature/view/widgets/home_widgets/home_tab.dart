import 'dart:async';
import 'package:ecommerce_app/core/images/images_path.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/controller/product_cubit/product_cubit.dart';
import 'package:ecommerce_app/feature/controller/product_cubit/product_states.dart';
import 'package:ecommerce_app/feature/view/widgets/home_widgets/announcements_section.dart';
import 'package:ecommerce_app/feature/view/widgets/category_widget.dart/category_item.dart';
import 'package:ecommerce_app/feature/view/widgets/custom_section_bar.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/feature/controller/category_cubit/category_cubit.dart';
import 'package:ecommerce_app/feature/view/screens/product_screens/products_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  late Timer _timer;
  final List<String> _announcementsImagesPaths = [
    ImagesPath.carouselSlider1,
    ImagesPath.carouselSlider2,
    ImagesPath.carouselSlider3,
  ];

  @override
  void initState() {
    super.initState();
    _startImageSwitching();
    // Load featured products
    context.read<ProductCubit>().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200, // Reduced height for announcements section
            child: AnnouncementsSection(
              imagesPaths: _announcementsImagesPaths,
              currentIndex: _currentIndex,
              timer: _timer,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.s16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Categories Section
                CustomSectionBar(
                  sectionName: 'Categories',
                  onViewAllClicked: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                          appBar: AppBar(title: Text('All Categories')),
                          body: BlocBuilder<CategoriesCubit, CategoriesState>(
                            builder: (context, state) {
                              if (state is CategoriesLoading) {
                                return Center(child: CircularProgressIndicator());
                              } else if (state is CategoriesLoaded) {
                                final categories = state.categories;
                                return GridView.builder(
                                  padding: EdgeInsets.all(Insets.s16),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                  ),
                                  itemCount: categories.length,
                                  itemBuilder: (_, index) {
                                    final category = categories[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ProductsScreen(categoryId: category.id),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.1),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                                child: Image.network(
                                                  category.image,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              category.name,
                                              style: getMediumStyle(
                                                color: ColorManager.primary,
                                                fontSize: FontSize.s16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is CategoriesError) {
                                return Center(child: Text(state.message));
                              }
                              return SizedBox();
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: Sizes.s16),
                SizedBox(
                  height: 150,
                  child: BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, state) {
                      if (state is CategoriesLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is CategoriesLoaded) {
                        final categories = state.categories;
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          separatorBuilder: (_, __) => SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ProductsScreen(categoryId: category.id),
                                  ),
                                );
                              },
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: const BoxDecoration(shape: BoxShape.circle),
                                        child: Image.network(
                                          category.image,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      category.name,
                                      style: getMediumStyle(
                                        color: ColorManager.primary,
                                        fontSize: FontSize.s14,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is CategoriesError) {
                        return Center(child: Text(state.message));
                      }
                      return SizedBox();
                    },
                  ),
                ),
                SizedBox(height: Sizes.s24),

                // Featured Products Section
                CustomSectionBar(
                  sectionName: 'Featured Products',
                  onViewAllClicked: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductsScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: Sizes.s16),
                BlocBuilder<ProductCubit, ProductStates>(
                  builder: (context, state) {
                    if (state is ProductLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ProductSuccessState) {
                      final products = context.read<ProductCubit>().allProductModel?.data ?? [];
                      return SizedBox(
                        height: 280,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          separatorBuilder: (_, __) => SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Container(
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ProductItem(
                                productId: product.id,
                                title: product.title,
                                price: product.price.toDouble(),
                                image: product.imageCover,
                                rating: product.ratingsAverage.toDouble(),
                                isInWishlist: false,
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is ProductErrorState) {
                      return Center(child: Text(state.error));
                    }
                    return SizedBox();
                  },
                ),
                SizedBox(height: Sizes.s24),

                // Special Offers Section
                Container(
                  padding: EdgeInsets.all(Insets.s16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorManager.primary.withOpacity(0.1),
                        ColorManager.primary.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Special Offers',
                        style: getBoldStyle(
                          color: ColorManager.primary,
                          fontSize: FontSize.s20,
                        ),
                      ),
                      SizedBox(height: Sizes.s16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Get 20% off',
                                  style: getBoldStyle(
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s24,
                                  ),
                                ),
                                SizedBox(height: Sizes.s8),
                                Text(
                                  'On your first purchase',
                                  style: getRegularStyle(
                                    color: ColorManager.text,
                                    fontSize: FontSize.s16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(Insets.s12),
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.local_offer,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Sizes.s24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 6500), (Timer timer) {
      setState(
        () => _currentIndex =
            (_currentIndex + 1) % _announcementsImagesPaths.length,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
