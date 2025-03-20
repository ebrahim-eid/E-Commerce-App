import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 36,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.s14),
          ),
          padding: EdgeInsets.symmetric(horizontal: Sizes.s1),
          backgroundColor: ColorManager.primary,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: getRegularStyle(
            color: ColorManager.white,
            fontSize: FontSize.s14,
          ),
        ),
      ),
    );
  }
}
