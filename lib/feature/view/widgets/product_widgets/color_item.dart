

import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  const ColorItem({
    required this.index,
    required this.color,
    required this.selectedIndex,
  });

  final Color color;
  final int index;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: color,
      child: Align(
        alignment: Alignment.center,
        child: Icon(
          Icons.check,
          color:
              index == selectedIndex ? ColorManager.white : Colors.transparent,
        ),
      ),
    );
  }
}
