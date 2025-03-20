import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String label;
  final Color? backgroundColor;
  final void Function() onTap;
  final TextStyle? textStyle;
  final bool isStadiumBorder;

  const CustomButton({
    this.prefixIcon,
    this.textStyle,
    this.isStadiumBorder = true,
    this.backgroundColor,
    this.suffixIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: isStadiumBorder
            ? const StadiumBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
        backgroundColor: backgroundColor ?? ColorManager.primary,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) ...[
            prefixIcon!,
            SizedBox(width: 8),
          ],
          Text(
            label,
            style: textStyle ??
                Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
          ),
          if (suffixIcon != null) ...[
            SizedBox(width: 8),
            suffixIcon!,
          ],
        ],
      ),
    );
  }
}