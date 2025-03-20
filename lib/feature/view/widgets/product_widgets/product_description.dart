import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {
  final String description;

  const ProductDescription({required this.description});

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: getMediumStyle(color: ColorManager.appBarTitle)
              .copyWith(fontSize: 18),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          isExpanded
              ? widget.description
              : widget.description.length > 100
                  ? '${widget.description.substring(0, 100)}...'
                  : widget.description,
          style: getMediumStyle(
            color: ColorManager.appBarTitle.withOpacity(.6),
          ).copyWith(fontSize: 18),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? 'Read Less' : 'Read More',
            style: getMediumStyle(
              color: ColorManager.appBarTitle,
            ).copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
