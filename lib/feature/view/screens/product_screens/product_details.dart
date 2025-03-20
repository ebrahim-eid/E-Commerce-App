

import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/images/icons_paths.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/feature/view/screens/cart_screens/cart_screen.dart';
import 'package:ecommerce_app/feature/view/widgets/auth_widgets/custom_button.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_counter.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_description.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_image.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_label.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_rating.dart';
import 'package:ecommerce_app/feature/view/widgets/product_widgets/product_slider.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails();

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Product Details',
          style: getMediumStyle(color: ColorManager.appBarTitle)
              .copyWith(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const ImageIcon(
              AssetImage(IconsPaths.search),
              color: ColorManager.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              HelperFunctions.navigateTo(context, CartScreen());
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16,
            end: 16,
            bottom: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductSlider(
                items: [
                  'https://pl.kicksmaniac.com/zdjecia/2022/08/23/508/43/NIKE_AIR_JORDAN_1_RETRO_HIGH_GS_RARE_AIR_MAX_ORANGE-mini.jpg',
                  'https://pl.kicksmaniac.com/zdjecia/2022/08/23/508/43/NIKE_AIR_JORDAN_1_RETRO_HIGH_GS_RARE_AIR_MAX_ORANGE-mini.jpg',
                ]
                    .map(
                      (imageURL) => ProductImage(imageUrl: imageURL),
                    )
                    .toList(),
                initialIndex: 0,
              ),
              SizedBox(
                height: 24,
              ),
              const ProductLabel(
                name: 'Nike Air Jordon Nike shoes flexible for wo..',
                price: 'EGP 399',
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Expanded(
                    child: ProductRating(
                      buyers: '1324',
                      rating: '4.8 (853)',
                    ),
                  ),
                  ProductCounter(
                    initialValue: _quantity,
                    onIncrement: (value) {
                      _quantity = value;
                    },
                    onDecrement: (value) {
                      _quantity = value;
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              const ProductDescription(
                description:
                    'Nike is a multinational corporation that designs, develops, and sells athletic footwear ,apparel, and accessories.',
              ),
              SizedBox(
                height: 48,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Total price',
                        style: getMediumStyle(
                          color: ColorManager.primary.withOpacity(.6),
                        ).copyWith(fontSize: 18),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'EGP 399',
                        style: getMediumStyle(
                          color: ColorManager.appBarTitle,
                        ).copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 33,
                  ),
                  Expanded(
                    child: CustomButton(
                      label: 'Add to cart',
                      onTap: () {},
                      prefixIcon: const Icon(
                        Icons.add_shopping_cart_outlined,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
