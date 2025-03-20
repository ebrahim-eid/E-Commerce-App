
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class SubCategoryItem extends StatelessWidget {
  final String title;
  final String image;

  const SubCategoryItem(
    this.title,
    this.image,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Navigator.of(context).pushNamed(Routes.products),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.s12),
                border: Border.all(
                  color: ColorManager.primary,
                  width: Sizes.s2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Sizes.s10),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: getRegularStyle(color: ColorManager.primary),
          ),
        ],
      ),
    );
  }
}
