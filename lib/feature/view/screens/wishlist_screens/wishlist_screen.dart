import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/view/widgets/wishlist_widgets/wishlist_item.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen();

  @override
  State<WishlistScreen> createState() => WishlistScreenState();
}

class WishlistScreenState extends State<WishlistScreen> {
  final List<Map<String, dynamic>> _favoriteProducts = const [
    {
      'title': 'Nike Air Jordon',
      'finalPrice': '1,200',
      'color': Color.fromARGB(255, 23, 23, 24),
      'imageUrl':
          'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/8402492b-1d6c-4811-af0f-4e3090c2ab59/AIR+JORDAN+1+RETRO+HIGH+OG.png',
      'salePrice': '1,500',
    },
    {
      'title': 'Tall Cotton Dress',
      'finalPrice': '600',
      'color': Color.fromARGB(255, 233, 123, 20),
      'imageUrl':
          'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/8402492b-1d6c-4811-af0f-4e3090c2ab59/AIR+JORDAN+1+RETRO+HIGH+OG.png',
      'salePrice': '750',
    },
    {
      'title': 'GUESS Women’s',
      'finalPrice': '1,200',
      'color': Color.fromARGB(255, 255, 148, 175),
      'imageUrl':
          'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/8402492b-1d6c-4811-af0f-4e3090c2ab59/AIR+JORDAN+1+RETRO+HIGH+OG.png',
      'salePrice': '1,500',
    },
    {
      'title': 'Nike Air Jordon',
      'finalPrice': '1,200',
      'color': Color.fromARGB(255, 23, 23, 24),
      'imageUrl':
          'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/8402492b-1d6c-4811-af0f-4e3090c2ab59/AIR+JORDAN+1+RETRO+HIGH+OG.png',
      'salePrice': '1,500',
    },
    {
      'title': 'Tall Cotton Dress',
      'finalPrice': '600',
      'color': Color.fromARGB(255, 233, 123, 20),
      'imageUrl':
          'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/8402492b-1d6c-4811-af0f-4e3090c2ab59/AIR+JORDAN+1+RETRO+HIGH+OG.png',
      'salePrice': '750',
    },
    {
      'title': 'GUESS Women’s',
      'finalPrice': '1,200',
      'color': Color.fromARGB(255, 255, 148, 175),
      'imageUrl':
          'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/8402492b-1d6c-4811-af0f-4e3090c2ab59/AIR+JORDAN+1+RETRO+HIGH+OG.png',
      'salePrice': '1,500',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.s14,
        vertical: Sizes.s10,
      ),
      child: ListView.builder(
        itemCount: _favoriteProducts.length,
        itemBuilder: (_, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: Sizes.s12),
          child: WishlistItem(product: _favoriteProducts[index]),
        ),
      ),
    );
  }
}
