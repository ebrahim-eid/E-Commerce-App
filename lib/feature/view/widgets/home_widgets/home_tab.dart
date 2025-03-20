import 'dart:async';
import 'package:ecommerce_app/core/images/images_path.dart';
import 'package:ecommerce_app/feature/view/widgets/home_widgets/announcements_section.dart';
import 'package:ecommerce_app/feature/view/widgets/category_widget.dart/category_item.dart';
import 'package:ecommerce_app/feature/view/widgets/custom_section_bar.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  late Timer _timer;
  final List<String> _announcementsImagesPaths = [
    ImagesPath.carouselSlider1,
    ImagesPath.carouselSlider2,
    ImagesPath.carouselSlider3,
  ];

  @override
  void initState() {
    super.initState();
    _startImageSwitching();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AnnouncementsSection(
            imagesPaths: _announcementsImagesPaths,
            currentIndex: _currentIndex,
            timer: _timer,
          ),
          Column(
            children: [
              CustomSectionBar(
                sectionName: 'Categories',
                onViewAllClicked: () {},
              ),
              SizedBox(
                height: 270,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (_, index) => const CategoryItem(),
                  itemCount: 8,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ],
      ),
    );
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 6500), (Timer timer) {
      setState(
        () => _currentIndex =
            (_currentIndex + 1) % _announcementsImagesPaths.length,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
