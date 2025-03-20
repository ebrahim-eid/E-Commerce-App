import 'package:ecommerce_app/feature/view/widgets/wishlist_widgets/heart_button.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final void Function()? onTap;

  const ProductImage({
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl), 
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15), 
      ),
      alignment: AlignmentDirectional.topEnd,
      child: HeartButton(
        onTap: onTap,
      ),
    );
  }
}
