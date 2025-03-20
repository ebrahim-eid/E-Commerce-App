import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CategoryTextItem extends StatelessWidget {
  final int index;
  final String title;
  final bool isSelected;
  final void Function(int) onItemClick;

  const CategoryTextItem(
    this.index,
    this.title,
    this.isSelected,
    this.onItemClick,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onItemClick(index),
      child: Container(
        color: isSelected ? ColorManager.white : Colors.transparent,
        padding: EdgeInsets.all(Insets.s8),
        child: Row(
          children: [
            Visibility(
              visible: isSelected,
              child: Container(
                width: Sizes.s8,
                height: Sizes.s60,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(Sizes.s100),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Insets.s16,
                  horizontal: Insets.s8,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: getMediumStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
