import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/feature/controller/wishlist_cubit/wishlist_cubit.dart';
import 'package:ecommerce_app/feature/controller/wishlist_cubit/get_wishlist_cubit.dart';
import 'package:ecommerce_app/feature/view/screens/product_screens/product_details.dart';
import 'package:ecommerce_app/feature/view/widgets/wishlist_widgets/heart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_states.dart';

class ProductItem extends StatelessWidget {
  final String productId;
  final String title;
  final double price;
  final String image;
  final double rating;
  final bool isInWishlist;

  const ProductItem({
    super.key,
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
    required this.isInWishlist,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ProductDetails(productId: productId),
        ),
      ),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        child: Container(
          width: screenSize.width * 0.44,
          height: screenSize.height * 0.32,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorManager.primary.withOpacity(0.12),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: ColorManager.primary.withOpacity(0.06),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 6,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                      child: Image.network(
                        image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 32),
                      ),
                    ),
                    PositionedDirectional(
                      top: 10,
                      end: 10,
                      child: BlocConsumer<WishlistCubit, WishlistState>(
                        listener: (context, state) async {
                          if (state is WishlistSuccess) {
                            final token = CashHelper.getToken();
                            if (token != null) {
                              await context.read<GetWishlistCubit>().refreshWishlist(token);
                            }
                          }
                        },
                        builder: (context, wishlistState) {
                          return HeartButton(
                            onTap: () {
                              final token = CashHelper.getToken();
                              if (token == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please login to use wishlist')),
                                );
                                return;
                              }
                              if (isInWishlist) {
                                context.read<WishlistCubit>().removeProductFromWishlist(productId, token);
                              } else {
                                context.read<WishlistCubit>().addProductToWishlist(productId, token);
                              }
                            },
                            filled: isInWishlist,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        _truncateTitle(title),
                        style: getMediumStyle(
                          color: ColorManager.text,
                          fontSize: 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'EGP ${price.toStringAsFixed(2)}',
                        style: getBoldStyle(
                          color: ColorManager.primary,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 6),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  rating.toStringAsFixed(1),
                                  style: getRegularStyle(
                                    color: ColorManager.text,
                                    fontSize: 13,
                                  ),
                                ),
                                const Icon(
                                  Icons.star_rate_rounded,
                                  color: ColorManager.starRate,
                                  size: 18,
                                ),
                              ],
                            ),
                            _AddToCartButton(productId: productId),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _truncateTitle(String title) {
    final List<String> words = title.split(' ');
    if (words.length <= 2) {
      return title;
    } else {
      return '${words.sublist(0, 2).join(' ')}..';
    }
  }
}

class _AddToCartButton extends StatefulWidget {
  final String productId;
  const _AddToCartButton({required this.productId});

  @override
  State<_AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<_AddToCartButton> {
  bool isLoading = false;

  void _handleAddToCart(BuildContext context) {
    final token = CashHelper.getToken();
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login first'),
          backgroundColor: ColorManager.error,
        ),
      );
      return;
    }
    setState(() => isLoading = true);
    context.read<CartCubit>().addProductToCart(
      productId: widget.productId,
      token: token,
    );
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isLoading ? null : () => _handleAddToCart(context),
      icon: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: ColorManager.primary,
              ),
            )
          : const Icon(
              Icons.add_shopping_cart,
              color: ColorManager.primary,
              size: 20,
            ),
    );
  }
}
