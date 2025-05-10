import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/controller/product_cubit/product_cubit.dart';
import 'package:ecommerce_app/feature/controller/product_cubit/product_states.dart';
import 'package:ecommerce_app/feature/controller/wishlist_cubit/get_wishlist_cubit.dart';
import 'package:ecommerce_app/feature/controller/wishlist_cubit/wishlist_cubit.dart';
import 'package:ecommerce_app/feature/view/screens/product_screens/product_details.dart';
import 'package:ecommerce_app/feature/view/widgets/home_widgets/home_screen_app_bar.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_states.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';

class ProductsScreen extends StatefulWidget {
  final String? categoryId;
  const ProductsScreen({this.categoryId});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getAllProducts();
    final token = CashHelper.getToken();
    if (token != null) {
      context.read<GetWishlistCubit>().getWishlist(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeScreenAppBar(
        automaticallyImplyLeading: true,
        showSearch: false,
      ),
      body: BlocBuilder<ProductCubit, ProductStates>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductSuccessState) {
            var products = context.read<ProductCubit>().allProductModel?.data ?? [];
            if (widget.categoryId != null) {
              products = products.where((p) => p.category.sId == widget.categoryId).toList();
            }
            if (products.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return BlocListener<WishlistCubit, WishlistState>(
              listener: (context, state) async {
                if (state is WishlistSuccess) {
                  final token = CashHelper.getToken();
                  if (token != null) {
                    await context.read<GetWishlistCubit>().refreshWishlist(token);
                  }
                }
              },
              child: BlocBuilder<GetWishlistCubit, GetWishlistState>(
                builder: (context, wishlistState) {
                  final wishlistIds = wishlistState is GetWishlistLoaded
                      ? wishlistState.wishlist.map((w) => w.id).toSet()
                      : <String>{};
                  return BlocListener<CartCubit, CartStates>(
                    listener: (context, state) {
                      if (state is AddToCartSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to cart successfully'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (state is AddToCartErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: ColorManager.error,
                          ),
                        );
                      }
                    },
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 7 / 9,
                      ),
                      itemBuilder: (_, index) {
                        final product = products[index];
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
                      itemCount: products.length,
                      padding: EdgeInsets.all(Insets.s16),
                    ),
                  );
                },
              ),
            );
          } else if (state is ProductErrorState) {
            return Center(child: Text(state.error));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
