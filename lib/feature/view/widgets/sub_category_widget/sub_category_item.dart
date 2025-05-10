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
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: SizedBox.shrink(), // No content displayed
    );
  }
}
