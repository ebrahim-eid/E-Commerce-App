
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List<int> sizes;
  final void Function() onSelected;

  const ProductSize({
    required this.sizes,
    required this.onSelected,
  });

  @override
  State<ProductSize> createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: getMediumStyle(color: ColorManager.appBarTitle)
              .copyWith(fontSize: 18),
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 45,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                setState(() => _selectedIndex = index);
                widget.onSelected();
              },
              child: CircleAvatar(
                radius: 22,
                backgroundColor: index == _selectedIndex
                    ? ColorManager.primary
                    : Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 9),
                  child: Text(
                    '$widget.size[index]',
                    style: getMediumStyle(
                      color: index == _selectedIndex
                          ? ColorManager.white
                          : ColorManager.appBarTitle,
                    ).copyWith(fontSize: 18),
                  ),
                ),
              ),
            ),
            separatorBuilder: (_, __) => SizedBox(
              width: 17,
            ),
            itemCount: widget.sizes.length,
          ),
        ),
      ],
    );
  }
}
