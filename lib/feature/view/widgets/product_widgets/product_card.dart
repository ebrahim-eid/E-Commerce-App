

import 'package:ecommerce_app/core/images/icons_paths.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final String description;
  final double priceBeforeDiscount;
  final double rating;

  const ProductCard({
    required this.image,
    required this.title,
    required this.price,
    required this.rating,
    required this.priceBeforeDiscount,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: 200,
      height: 280,
      child: Container(
        width: 280,
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: ColorManager.primary.withOpacity(0.8),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SizedBox(
                    height: height,
                    child: ClipRRect(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(24),
                        topEnd: Radius.circular(24),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: height * 0.01,
                    end: width * 0.02,
                    child: Container(
                      height: height * 0.036,
                      width: width * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Image.asset(
                          IconsPaths.wishlist,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _truncateTitle(title),
                      style: getMediumStyle(
                        color: ColorManager.primary,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _truncateTitle(description),
                      style: getRegularStyle(
                        color: ColorManager.primary,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'EGP $price',
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: getRegularStyle(
                            color: ColorManager.primary,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '$priceBeforeDiscount EGP ',
                          style: getTextWithLine(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Reviews',
                              style: getRegularStyle(
                                color: ColorManager.primary,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '$rating',
                              style: getRegularStyle(
                                color: ColorManager.primary,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.add_circle_rounded,
                            color: ColorManager.primary,
                            size: 36,
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
    if (words.length <= 4) {
      return title;
    } else {
      return '${words.sublist(0, 4).join(' ')}..';
    }
  }
}
