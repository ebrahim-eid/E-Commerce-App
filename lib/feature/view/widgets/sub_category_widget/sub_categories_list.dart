import 'package:ecommerce_app/core/images/images_path.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/view/widgets/category_widget.dart/category_card_item.dart';
import 'package:ecommerce_app/feature/view/widgets/sub_category_widget/sub_category_item.dart';
import 'package:flutter/material.dart';

class SubCategoriesList extends StatelessWidget {
  const SubCategoriesList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              'Laptops',
              style: getBoldStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s14,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: CategoryCardItem(
              'Laptops',
              ImagesPath.categoryCardImage,
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: 26,
              (_, index) => const SubCategoryItem(
                'Watches',
                ImagesPath.subcategoryCardImage,
              ),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.75,
              mainAxisSpacing: Sizes.s8,
              crossAxisSpacing: Sizes.s8,
            ),
          ),
        ],
      ),
    );
  }
}
