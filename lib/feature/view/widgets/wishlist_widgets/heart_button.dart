import 'package:ecommerce_app/core/images/icons_paths.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class HeartButton extends StatelessWidget {
  final void Function()? onTap;
  final bool filled;

  const HeartButton({required this.onTap, required this.filled, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onTap: onTap,
      child: Material(
        color: ColorManager.white,
        elevation: 5,
        shape: const StadiumBorder(),
        shadowColor: ColorManager.black,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: ImageIcon(
            AssetImage(filled ? IconsPaths.clickedHeart : IconsPaths.heart),
            color: ColorManager.primary,
          ),
        ),
      ),
    );
  }
}
