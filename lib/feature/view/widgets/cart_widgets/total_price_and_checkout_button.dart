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
    // Convert price to string to calculate its length
    final priceString = 'EGP $totalPrice';
    final priceLength = priceString.length;
    
    // Calculate width based on price length
    final priceWidth = priceLength * 12.0; // Approximate width per character
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
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
              const SizedBox(height: 4),
              SizedBox(
                width: priceWidth.clamp(90.0, 200.0), // Min width 90, max width 200
                child: Text(
                  priceString,
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
          const SizedBox(width: 18),
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
      ),
    );
  }
}
