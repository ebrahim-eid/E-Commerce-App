

import 'package:ecommerce_app/core/images/images_path.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

class ProductRating extends StatelessWidget {
  final String rating;
  final String buyers;

  const ProductRating({
    required this.rating,
    required this.buyers,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorManager.primary.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '$buyers Sold',
            overflow: TextOverflow.ellipsis,
            style: getMediumStyle(color: ColorManager.primary)
                .copyWith(fontSize: 18),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Image.asset(
          ImagesPath.rate,
          width: 30,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            rating,
            overflow: TextOverflow.ellipsis,
            style: getMediumStyle(color: ColorManager.appBarTitle)
                .copyWith(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
