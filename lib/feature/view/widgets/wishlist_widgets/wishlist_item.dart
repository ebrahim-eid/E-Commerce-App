import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/controller/wishlist_cubit/wishlist_cubit.dart';
import 'package:ecommerce_app/feature/model/wishlist_model/wishlist_model.dart';
import 'package:ecommerce_app/feature/view/screens/product_screens/product_details.dart';
import 'package:ecommerce_app/feature/view/widgets/wishlist_widgets/add_to_cart_button.dart';
import 'package:ecommerce_app/feature/view/widgets/wishlist_widgets/heart_button.dart';
import 'package:ecommerce_app/feature/view/widgets/wishlist_widgets/wishlist_item_details.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/feature/model/all_products_model/single_product_data_model.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_states.dart';

class WishlistItem extends StatefulWidget {
  const WishlistItem({required this.product, required this.isInWishlist, Key? key}) : super(key: key);

  final WishlistModel product;
  final bool isInWishlist;

  @override
  State<WishlistItem> createState() => _WishlistItemState();
}

class _WishlistItemState extends State<WishlistItem> {
  String? title;
  String? imageUrl;
  bool loading = false;
  bool isAddingToCart = false;

  @override
  void initState() {
    super.initState();
    if (widget.product.name.isEmpty || widget.product.image.isEmpty) {
      fetchProduct();
    } else {
      title = widget.product.name;
      imageUrl = widget.product.image;
    }
  }

  Future<void> fetchProduct() async {
    setState(() => loading = true);
    try {
      final response = await Dio().get('https://ecommerce.routemisr.com/api/v1/products/${widget.product.id}');
      final single = SingleProductDataModel.fromJson(response.data);
      setState(() {
        title = single.title;
        imageUrl = single.imageCover;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading || title == null || imageUrl == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(Sizes.s16),
      color: Colors.white,
      child: InkWell(
        onTap: () => HelperFunctions.navigateTo(context, ProductDetails(productId: widget.product.id)),
        child: Container(
          height: Sizes.s135,
          padding: EdgeInsetsDirectional.only(end: Sizes.s8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.s16),
            border: Border.all(color: ColorManager.primary.withOpacity(.18)),
            boxShadow: [
              BoxShadow(
                color: ColorManager.primary.withOpacity(.06),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: Sizes.s100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Sizes.s16),
                  border: Border.all(color: ColorManager.primary.withOpacity(.12)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.s16),
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    width: Sizes.s100,
                    height: Sizes.s100,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: Insets.s8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6),
                      Text(
                        'EGP ${widget.product.price}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.primary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  HeartButton(
                    onTap: () {
                      final token = CashHelper.getToken();
                      if (token == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please login to use wishlist')),
                        );
                        return;
                      }
                      if (widget.isInWishlist) {
                        BlocProvider.of<WishlistCubit>(context).removeProductFromWishlist(widget.product.id, token);
                      } else {
                        BlocProvider.of<WishlistCubit>(context).addProductToWishlist(widget.product.id, token);
                      }
                    },
                    filled: widget.isInWishlist,
                  ),
                  SizedBox(height: Sizes.s14),
                  isAddingToCart
                      ? const SizedBox(
                          width: 36,
                          height: 36,
                          child: CircularProgressIndicator(strokeWidth: 2, color: ColorManager.primary),
                        )
                      : AddToCartButton(
                          onPressed: () async {
                            final token = CashHelper.getToken();
                            if (token == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please login to add to cart')),
                              );
                              return;
                            }
                            setState(() => isAddingToCart = true);
                            try {
                              context.read<CartCubit>().addProductToCart(
                                productId: widget.product.id,
                                token: token,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Added to cart successfully')), // Optionally listen to cubit for more robust feedback
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to add to cart: $e')),
                              );
                            } finally {
                              setState(() => isAddingToCart = false);
                            }
                          },
                          text: 'Add to Cart',
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
