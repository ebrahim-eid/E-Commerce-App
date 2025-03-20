import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/view/widgets/category_widget.dart/categories_list.dart';
import 'package:ecommerce_app/feature/view/widgets/sub_category_widget/sub_categories_list.dart';
import 'package:flutter/material.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Insets.s12,
        vertical: Insets.s12,
      ),
      child: Row(
        children: [
          const CategoriesList(),
          SizedBox(
            width: Sizes.s16,
          ),
          const SubCategoriesList(),
        ],
      ),
    );
  }
}
