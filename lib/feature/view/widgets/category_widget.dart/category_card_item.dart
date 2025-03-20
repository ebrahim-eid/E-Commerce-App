
import 'package:ecommerce_app/core/resources/color_manager.dart' show ColorManager;
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CategoryCardItem extends StatelessWidget {
  final String title;
  final String image;

  const CategoryCardItem(
    this.title,
    this.image,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Insets.s16),
      height: Sizes.s100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes.s12),
        child: Stack(
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Insets.s18,
                  vertical: Insets.s8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            title,
                            style: getBoldStyle(
                              color: ColorManager.text,
                              fontSize: FontSize.s16,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: 110,
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(120, 30),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 0,
                                ),
                                backgroundColor: ColorManager.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Shop Now',
                                style:
                                    getRegularStyle(color: ColorManager.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
