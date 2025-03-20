

import 'package:ecommerce_app/feature/view/widgets/product_widgets/color_item.dart';
import 'package:flutter/material.dart';

class ProductColor extends StatefulWidget {
  final List<Color> color;
  final void Function() onSelected;

  const ProductColor({
    required this.color,
    required this.onSelected,
  });

  @override
  State<ProductColor> createState() => _ProductColorState();
}

class _ProductColorState extends State<ProductColor> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              child: ColorItem(
                color: widget.color[index],
                index: index,
                selectedIndex: _selectedIndex,
              ),
            ),
            separatorBuilder: (_, __) => SizedBox(
              width: 17,
            ),
            itemCount: widget.color.length,
          ),
        ),
      ],
    );
  }
}
