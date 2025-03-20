import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

class ProductCounter extends StatefulWidget {
  final int initialValue;
  final void Function(int) onIncrement;
  final void Function(int) onDecrement;

  const ProductCounter({
    required this.onIncrement,
    required this.onDecrement,
    required this.initialValue,
  });

  @override
  State<ProductCounter> createState() => _ProductCounterState();
}

class _ProductCounterState extends State<ProductCounter> {
  late int _counter = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (_counter == 1) return;
              setState(() => _counter--);
              widget.onDecrement(_counter);
            },
            child: Icon(
              Icons.remove_circle_outline,
              size: 20,
              color: ColorManager.white,
            ),
          ),
          SizedBox(
            width: 18,
          ),
          Text(
            '$_counter',
            style: getMediumStyle(color: ColorManager.white)
                .copyWith(fontSize: 18),
          ),
          SizedBox(
            width: 18,
          ),
          InkWell(
            onTap: () {
              setState(() => _counter++);
              widget.onIncrement(_counter);
            },
            child: Icon(
              Icons.add_circle_outline,
              color: ColorManager.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
