import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/view/widgets/wishlist_widgets/custom_auto_size_text.dart';
import 'package:flutter/material.dart';

class WishlistItemDetails extends StatelessWidget {
  const WishlistItemDetails({required this.product});

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomAutoSizeText(
          data: product['title'],
          textStyle: getSemiBoldStyle(
            color: ColorManager.primaryDark,
            fontSize: FontSize.s18,
          ),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(end: Sizes.s10),
              width: Sizes.s14,
              height: Sizes.s14,
              decoration: BoxDecoration(
                color: product['color'],
                shape: BoxShape.circle,
              ),
            ),
            // CustomAutoSizeText(
            //   data: product['colorName'],
            //   textStyle: getMediumStyle(
            //     color: ColorManager.primaryDark,
            //     fontSize: FontSize.s14,
            //   ),
            // ),
          ],
        ),
        Row(
          children: [
            CustomAutoSizeText(
              data: 'EGP ${product['finalPrice']}  ',
              textStyle: getSemiBoldStyle(
                color: ColorManager.primaryDark,
                fontSize: FontSize.s18,
              ).copyWith(
                letterSpacing: 0.17,
              ),
            ),
            product['salePrice'] == null
                ? const SizedBox.shrink()
                : Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: Sizes.s10,
                        ),
                        CustomAutoSizeText(
                          data: 'EGP ${product['salePrice']}',
                          textStyle: getMediumStyle(
                            color: ColorManager.appBarTitle.withOpacity(.6),
                          ).copyWith(
                            letterSpacing: 0.17,
                            decoration: TextDecoration.lineThrough,
                            color: ColorManager.appBarTitle.withOpacity(.6),
                            fontSize: FontSize.s10,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
