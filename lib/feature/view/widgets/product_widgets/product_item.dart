
import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/feature/view/screens/product_screens/product_details.dart';
import 'package:ecommerce_app/feature/view/widgets/wishlist_widgets/heart_button.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return InkWell(
      onTap: () => HelperFunctions.navigateAndRemove(context, ProductDetails()),
      child: Container(
        width: screenSize.width * 0.4,
        height: screenSize.height * 0.3,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorManager.primary.withOpacity(0.3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(14)),
                    child: Image.network(
                          'https://pl.kicksmaniac.com/zdjecia/2022/08/23/508/43/NIKE_AIR_JORDAN_1_RETRO_HIGH_GS_RARE_AIR_MAX_ORANGE-mini.jpg',
                      width: screenSize.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  PositionedDirectional(
                    top: screenSize.height * 0.01,
                    end: screenSize.width * 0.02,
                    child: HeartButton(onTap: () {}),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _truncateTitle(
                        'Nike Air Jordon Nike shoes flexible for wo..',
                      ),
                      style: getMediumStyle(
                        color: ColorManager.text,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.002),
                    Text(
                      _truncateDescription(
                        'Nike is a multinational corporation that designs, develops, and sells athletic footwear ,apparel, and accessories.',
                      ),
                      style: getRegularStyle(
                        color: ColorManager.text,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    SizedBox(
                      width: screenSize.width * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'EGP 399',
                            style: getRegularStyle(
                              color: ColorManager.text,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '499',
                            style: getTextWithLine(),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Review (4.8)',
                                style: getRegularStyle(
                                  color: ColorManager.text,
                                  fontSize: 12,
                                ),
                              ),
                              const Icon(
                                Icons.star_rate_rounded,
                                color: ColorManager.starRate,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: screenSize.height * 0.025,
                              width: screenSize.width * 0.08,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorManager.primary,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
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

  String _truncateTitle(String title) {
    final List<String> words = title.split(' ');
    if (words.length <= 2) {
      return title;
    } else {
      return '${words.sublist(0, 2).join(' ')}..';
    }
  }

  String _truncateDescription(String description) {
    final List<String> words = description.split(RegExp(r'[\s-]+'));
    if (words.length <= 4) {
      return description;
    } else {
      return '${words.sublist(0, 4).join(' ')}..';
    }
  }
}
