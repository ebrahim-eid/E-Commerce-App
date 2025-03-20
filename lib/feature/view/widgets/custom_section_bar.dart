import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CustomSectionBar extends StatelessWidget {
  final String sectionName;
  final VoidCallback onViewAllClicked;

  const CustomSectionBar({
    super.key,
    required this.sectionName,
    required this.onViewAllClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.s16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            sectionName,
            style: getMediumStyle(fontSize: 18, color: ColorManager.darkBlue),
          ),
          TextButton(
            onPressed: onViewAllClicked,
            child: Text(
              'view all',
              style: getMediumStyle(color: ColorManager.darkBlue),
            ),
          ),
        ],
      ),
    );
  }
}
