

import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/feature/view/widgets/auth_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class TotalPriceAndCheckoutButton extends StatelessWidget {
  const TotalPriceAndCheckoutButton({
    required this.totalPrice,
    required this.checkoutButtonOnTap,
  });

  final int totalPrice;
  final void Function() checkoutButtonOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total price',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: getMediumStyle(
                color: ColorManager.text.withOpacity(0.6),
                fontSize: FontSize.s18,
              ),
            ),
            SizedBox(height: 4),
            SizedBox(
              width: 90,
              child: Text(
                'EGP $totalPrice',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: getMediumStyle(
                  color: ColorManager.text,
                  fontSize: FontSize.s18,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 18),
        Expanded(
          child: CustomButton(
            label: 'Check Out',
            onTap: checkoutButtonOnTap,
            suffixIcon: const Icon(
              Icons.arrow_forward,
              color: ColorManager.white,
            ),
          ),
        ),
      ],
    );
  }
}
