import 'dart:async';
import 'package:ecommerce_app/core/images/images_path.dart';
import 'package:ecommerce_app/feature/view/widgets/home_widgets/announcements_section.dart';
import 'package:ecommerce_app/feature/view/widgets/category_widget.dart/category_item.dart';
import 'package:ecommerce_app/feature/view/widgets/custom_section_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/feature/controller/category_cubit/category_cubit.dart';
import 'package:ecommerce_app/feature/view/screens/product_screens/products_screen.dart';

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
                onViewAllClicked: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Scaffold(
                        appBar: AppBar(title: Text('All Categories')),
                        body: BlocBuilder<CategoriesCubit, CategoriesState>(
                          builder: (context, state) {
                            if (state is CategoriesLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is CategoriesLoaded) {
                              final categories = state.categories;
                              return GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                ),
                                itemCount: categories.length,
                                itemBuilder: (_, index) {
                                  final category = categories[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ProductsScreen(categoryId: category.id),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: const BoxDecoration(shape: BoxShape.circle),
                                            child: Image.network(
                                              category.image,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          category.name,
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else if (state is CategoriesError) {
                              return Center(child: Text(state.message));
                            }
                            return SizedBox();
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 150,
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is CategoriesLoaded) {
                      final categories = state.categories;
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (_, __) => SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ProductsScreen(categoryId: category.id),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(shape: BoxShape.circle),
                                    child: Image.network(
                                      category.image,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  category.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (state is CategoriesError) {
                      return Center(child: Text(state.message));
                    }
                    return SizedBox();
                  },
                ),
              ),
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
