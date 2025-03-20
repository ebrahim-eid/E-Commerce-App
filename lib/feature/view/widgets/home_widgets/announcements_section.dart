import 'dart:async';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';


class AnnouncementsSection extends StatelessWidget {
  final List<String> imagesPaths;
  final int currentIndex;
  final Timer timer;

  const AnnouncementsSection({
    required this.imagesPaths,
    required this.currentIndex,
    required this.timer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.s16),
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 2500),
            child: Image.asset(
              height: 210,
              width: double.infinity,
              imagesPaths[currentIndex],
              key: ValueKey<int>(currentIndex),
            ),
          ),
          SizedBox(
            height: 210,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: imagesPaths.map((image) {
                final int index = imagesPaths.indexOf(image);
                return Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? ColorManager.primary
                        : Colors.grey,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
