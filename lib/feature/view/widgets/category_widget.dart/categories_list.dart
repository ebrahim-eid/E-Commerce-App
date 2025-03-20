import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/view/widgets/category_widget.dart/category_text_item.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList();

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.containerGray,
          border: BorderDirectional(
            top: BorderSide(
              width: Sizes.s2,
              color: ColorManager.primary.withOpacity(0.3),
            ),
            start: BorderSide(
              width: Sizes.s2,
              color: ColorManager.primary.withOpacity(0.3),
            ),
            bottom: BorderSide(
              width: Sizes.s2,
              color: ColorManager.primary.withOpacity(0.3),
            ),
          ),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(Sizes.s12),
            bottomStart: Radius.circular(Sizes.s12),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(Sizes.s12),
            bottomStart: Radius.circular(Sizes.s12),
          ),
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (_, index) => CategoryTextItem(
              index,
              'Laptops',
              _selectedIndex == index,
              onItemClick,
            ),
          ),
        ),
      ),
    );
  }

  void onItemClick(int index) => setState(() => _selectedIndex = index);
}
