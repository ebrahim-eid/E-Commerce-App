
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

class ProductLabel extends StatelessWidget {
  const ProductLabel({
    required this.name,
    required this.price,
  });

  final String name;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            style: getMediumStyle(color: ColorManager.primary)
                .copyWith(fontSize: 18),
          ),
        ),
        Text(
          price,
          style: getMediumStyle(color: ColorManager.primary)
              .copyWith(fontSize: 18),
        ),
      ],
    );
  }
}
