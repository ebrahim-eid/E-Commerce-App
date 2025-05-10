import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/images/icons_paths.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/feature/controller/product_cubit/product_cubit.dart';
import 'package:ecommerce_app/feature/controller/product_cubit/product_states.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/feature/view/screens/cart_screens/cart_screen.dart';
import 'package:ecommerce_app/feature/view/widgets/auth_widgets/custom_button.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_counter.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_description.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_image.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_label.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_rating.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:ecommerce_app/feature/controller/wishlist_cubit/get_wishlist_cubit.dart';
import 'package:ecommerce_app/feature/controller/wishlist_cubit/wishlist_cubit.dart';
import 'package:ecommerce_app/feature/view/widgets/wishlist_widgets/heart_button.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_states.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  final bool fromCart;
  const ProductDetails({Key? key, required this.productId, this.fromCart = false}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorManager.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Product Details',
          style: getMediumStyle(color: ColorManager.appBarTitle)
              .copyWith(fontSize: 20),
        ),
        actions: [
          BlocConsumer<WishlistCubit, WishlistState>(
            listener: (context, wishlistState) async {
              if (wishlistState is WishlistSuccess) {
                final token = CashHelper.getToken();
                if (token != null) {
                  await context.read<GetWishlistCubit>().refreshWishlist(token);
                }
              }
            },
            builder: (context, wishlistState) {
              return BlocBuilder<GetWishlistCubit, GetWishlistState>(
                builder: (context, wishlistState) {
                  final wishlistIds = wishlistState is GetWishlistLoaded
                      ? wishlistState.wishlist.map((w) => w.id).toSet()
                      : <String>{};
                  final isInWishlist = wishlistIds.contains(widget.productId);
                  return HeartButton(
                    filled: isInWishlist,
                    onTap: () async {
                      final token = CashHelper.getToken();
                      if (token == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please login to use wishlist')),
                        );
                        return;
                      }
                      if (isInWishlist) {
                        await context.read<WishlistCubit>().removeProductFromWishlist(widget.productId, token);
                      } else {
                        await context.read<WishlistCubit>().addProductToWishlist(widget.productId, token);
                      }
                    },
                  );
                },
              );
            },
          ),
          if (!(widget.fromCart ?? false))
            IconButton(
              onPressed: () {
                HelperFunctions.navigateTo(context, CartScreen());
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: ColorManager.primary,
              ),
            ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductStates>(
        builder: (context, state) {
          if (state is ProductByIdLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductByIdSuccessState) {
            final product = context.read<ProductCubit>().singleProductDataModel;
            if (product == null) {
              return const Center(child: Text('Product not found'));
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 16,
                  end: 16,
                  bottom: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductSlider(
                      items: product.images
                          .map((imageURL) => ProductImage(imageUrl: imageURL))
                          .toList(),
                      initialIndex: 0,
                    ),
                    const SizedBox(height: 24),
                    ProductLabel(
                      name: product.title,
                      price: 'EGP ${product.price}',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ProductRating(
                            buyers: product.ratingsQuantity.toString(),
                            rating: '${product.ratingsAverage} (${product.ratingsQuantity})',
                          ),
                        ),
                        ProductCounter(
                          initialValue: _quantity,
                          onIncrement: (value) {
                            setState(() => _quantity = value);
                          },
                          onDecrement: (value) {
                            setState(() => _quantity = value);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ProductDescription(
                      description: product.description,
                    ),
                    const SizedBox(height: 48),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Total price',
                              style: getMediumStyle(
                                color: ColorManager.primary.withOpacity(.6),
                              ).copyWith(fontSize: 18),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'EGP ${product.price * _quantity}',
                              style: getMediumStyle(
                                color: ColorManager.appBarTitle,
                              ).copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(width: 33),
                        Expanded(
                          child: BlocConsumer<CartCubit, CartStates>(
                            listener: (context, cartState) {
                              if (cartState is AddToCartSuccessState || cartState is UpdateCartItemSuccessState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Added to cart successfully!')),
                                );
                              } else if (cartState is AddToCartErrorState || cartState is UpdateCartItemErrorState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(cartState is AddToCartErrorState ? (cartState as AddToCartErrorState).error : (cartState as UpdateCartItemErrorState).error)),
                                );
                              }
                            },
                            builder: (context, cartState) {
                              final isLoading = cartState is AddToCartLoadingState || cartState is UpdateCartItemLoadingState;
                              return CustomButton(
                                label: isLoading ? 'Adding...' : 'Add to cart',
                                onTap: isLoading ? null : () {
                                  final token = CashHelper.getToken();
                                  if (token == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please login to add to cart')),
                                    );
                                    return;
                                  }
                                  if (_quantity < 1) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Quantity must be at least 1')),
                                    );
                                    return;
                                  }
                                  context.read<CartCubit>().addProductToCart(
                                    productId: product.id,
                                    token: token,
                                  );
                                  if (_quantity > 1) {
                                    context.read<CartCubit>().updateCartItemQuantity(
                                      productId: product.id,
                                      count: _quantity,
                                      token: token,
                                    );
                                  }
                                },
                                prefixIcon: const Icon(
                                  Icons.add_shopping_cart_outlined,
                                  color: ColorManager.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProductByIdErrorState) {
            return Center(child: Text(state.error));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
