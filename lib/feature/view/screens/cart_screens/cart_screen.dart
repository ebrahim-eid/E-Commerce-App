

import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/view/widgets/cart_widgets/cart_item.dart';
import 'package:ecommerce_app/feature/view/widgets/cart_widgets/total_price_and_checkout_button.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: getMediumStyle(fontSize: 20, color: ColorManager.text),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Insets.s14),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) => const CartItem(),
                itemCount: 2,
                separatorBuilder: (_, __) => SizedBox(height: Sizes.s12),
              ),
            ),
            TotalPriceAndCheckoutButton(
              totalPrice: 399,
              checkoutButtonOnTap: () {},
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
