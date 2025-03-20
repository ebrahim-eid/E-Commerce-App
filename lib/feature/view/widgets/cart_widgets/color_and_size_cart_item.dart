

import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

class ColorAndSizeCartItem extends StatelessWidget {
  const ColorAndSizeCartItem({
    required this.color,
    required this.colorName,
    required this.size,
  });

  final Color color;
  final String colorName;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 7.5,
          backgroundColor: color,
        ),
        SizedBox(width: 5),
        Text(
          colorName,
          style: getRegularStyle(
            color: ColorManager.text.withOpacity(0.5),
            fontSize: FontSize.s14,
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: 2,
          height: 18,
          decoration: BoxDecoration(
            color: ColorManager.grey1,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(width: 5),
        Text(
          'Size: $size',
          style: getRegularStyle(
            color: ColorManager.text.withOpacity(0.5),
            fontSize: FontSize.s14,
          ),
        ),
      ],
    );
  }
}
