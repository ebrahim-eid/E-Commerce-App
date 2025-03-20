import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => HelperFunctions.navigateAndRemove(context, ProductScreen()),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.network(
                'https://helios-i.mashable.com/imagery/articles/05djrP5PjtVB7CcMtvrTOAP/images-4.fill.size_2000x1125.v1723100793.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Laptops',
            style: getRegularStyle(
              color: ColorManager.darkBlue,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
