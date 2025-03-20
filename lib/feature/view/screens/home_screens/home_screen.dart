import 'package:ecommerce_app/core/images/icons_paths.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/feature/view/screens/profile_screens/profile_screen.dart';
import 'package:ecommerce_app/feature/view/screens/wishlist_screens/wishlist_screen.dart';
import 'package:ecommerce_app/feature/view/widgets/category_widget.dart/categories_tab.dart';
import 'package:ecommerce_app/feature/view/widgets/home_widgets/home_screen_app_bar.dart';
import 'package:ecommerce_app/feature/view/widgets/home_widgets/home_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    const HomeTab(),
    const CategoriesTab(),
    const WishlistScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeScreenAppBar(),
      extendBody: false,
      body: tabs[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(15),
          topEnd: Radius.circular(15),
        ),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.1,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) => changeSelectedIndex(value),
            backgroundColor: ColorManager.primary,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              CustomBottomNavBarItem(IconsPaths.home, 'Home'),
              CustomBottomNavBarItem(IconsPaths.categories, 'Categories'),
              CustomBottomNavBarItem(IconsPaths.wishlist, 'WishList'),
              CustomBottomNavBarItem(IconsPaths.profile, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  void changeSelectedIndex(int selectedIndex) =>
      setState(() => currentIndex = selectedIndex);
}

class CustomBottomNavBarItem extends BottomNavigationBarItem {
  final String iconPath;
  final String title;

  CustomBottomNavBarItem(this.iconPath, this.title)
      : super(
          label: title,
          icon: ImageIcon(
            AssetImage(iconPath),
            color: ColorManager.white,
          ),
          activeIcon: CircleAvatar(
            radius: 12,
            backgroundColor: ColorManager.white,
            child: ImageIcon(
              AssetImage(iconPath),
              color: ColorManager.primary,
              size: 14,
            ),
          ),
        );
}