import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/model/cart_models/add_product_to_cart_model.dart' as cart_model;
import 'package:ecommerce_app/feature/view/screens/product_screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/feature/model/all_products_model/single_product_data_model.dart';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatefulWidget {
  final cart_model.CartProduct cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItem({
    super.key,
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  cart_model.ProductDetails? productDetails;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.cartItem.product.title.isEmpty) {
      fetchProduct();
    } else {
      productDetails = widget.cartItem.product;
    }
  }

  Future<void> fetchProduct() async {
    setState(() => loading = true);
    try {
      final response = await Dio().get('https://ecommerce.routemisr.com/api/v1/products/${widget.cartItem.product.id}');
      final single = SingleProductDataModel.fromJson(response.data);
      setState(() {
        productDetails = cart_model.ProductDetails(
          id: single.id,
          title: single.title,
          imageCover: single.imageCover,
          ratingsAverage: single.ratingsAverage,
        );
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading || productDetails == null) {
      return Center(child: CircularProgressIndicator());
    }
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      child: InkWell(
        onTap: () => HelperFunctions.navigateTo(
          context,
          ProductDetails(productId: productDetails!.id, fromCart: true),
        ),
        child: Container(
          height: isPortrait ? height * 0.14 : width * 0.23,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: isPortrait ? width * 0.25 : width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(productDetails!.imageCover),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          productDetails!.title,
                          style: getBoldStyle(
                            color: ColorManager.text,
                            fontSize: FontSize.s16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'EGP ${widget.cartItem.price}',
                        style: getBoldStyle(
                          color: ColorManager.primary,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  if (widget.cartItem.count > 1) {
                                    widget.onQuantityChanged(widget.cartItem.count - 1);
                                  }
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  size: 20,
                                  color: ColorManager.primary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  '${widget.cartItem.count}',
                                  style: getBoldStyle(
                                    color: ColorManager.text,
                                    fontSize: FontSize.s16,
                                  ),
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  widget.onQuantityChanged(widget.cartItem.count + 1);
                                },
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  size: 20,
                                  color: ColorManager.primary,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              final token = CashHelper.getToken();
                              if (token != null) {
                                context.read<CartCubit>().removeSpecificCartItem(
                                  id: productDetails!.id,
                                  token: token,
                                );
                              }
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              size: 22,
                              color: Colors.red,
                            ),
                          ),
                        ],
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
}
