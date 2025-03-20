

import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/images/icons_paths.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/view/screens/product_screens/product_details.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_counter.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem();

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return InkWell(
      onTap: () => HelperFunctions.navigateAndRemove(context, ProductDetails()),  
      child: Container(
        height: isPortrait ? height * 0.14 : width * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: ColorManager.primary.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border:
                    Border.all(color: ColorManager.primary.withOpacity(0.3)),
              ),
              child: Image.network(
                
                    'https://pl.kicksmaniac.com/zdjecia/2022/08/23/508/43/NIKE_AIR_JORDAN_1_RETRO_HIGH_GS_RARE_AIR_MAX_ORANGE-mini.jpg',
                fit: BoxFit.cover,
                height: isPortrait ? height * 0.142 : height * 0.23,
                width: isPortrait ? width * 0.29 : 165,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Insets.s8,
                  vertical: Insets.s8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Nike Air Jordon Nike shoes flexible for wo..',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getBoldStyle(
                              color: ColorManager.text,
                              fontSize: FontSize.s18,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            IconsPaths.delete,
                            color: ColorManager.text,
                            height: 22,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'EGP 399',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getBoldStyle(
                              color: ColorManager.text,
                              fontSize: FontSize.s18,
                            ),
                          ),
                        ),
                        ProductCounter(
                          initialValue: 1,
                          onIncrement: (quantity) {},
                          onDecrement: (quantity) {},
                        ),
                      ],
                    ),
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
