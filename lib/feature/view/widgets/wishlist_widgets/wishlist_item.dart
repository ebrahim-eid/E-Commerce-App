import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/view/screens/product_screens/product_details.dart';
import 'package:ecommerce_app/feature/view/widgets/wishlist_widgets/add_to_cart_button.dart';
import 'package:ecommerce_app/feature/view/widgets/wishlist_widgets/heart_button.dart';
import 'package:ecommerce_app/feature/view/widgets/wishlist_widgets/wishlist_item_details.dart';
import 'package:flutter/material.dart';

class WishlistItem extends StatelessWidget {
  const WishlistItem({required this.product});

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => HelperFunctions.navigateTo(context, ProductDetails()),
      child: Container(
        height: Sizes.s135,
        padding: EdgeInsetsDirectional.only(end: Sizes.s8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.s16),
          border: Border.all(color: ColorManager.primary.withOpacity(.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.s16),
                border: Border.all(color: ColorManager.primary.withOpacity(.6)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Sizes.s16),
                child: Image.network(
                  product['imageUrl'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: Insets.s8),
                child: WishlistItemDetails(
                  product: product,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                HeartButton(
                  onTap: () {},
                ),
                SizedBox(height: Sizes.s14),
                AddToCartButton(
                  onPressed: () {},
                  text: 'Add to Cart',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
