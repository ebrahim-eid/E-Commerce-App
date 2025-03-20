import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class ProductSlider extends StatefulWidget {
  final List<Widget> items;
  final int initialIndex;

  const ProductSlider({
    required this.items,
    required this.initialIndex,
  });

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  late int _currentIndex = widget.initialIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300, 
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            children: widget.items,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.items.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == index ? 12 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? ColorManager.primary
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
