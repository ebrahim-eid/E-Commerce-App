import 'package:ecommerce_app/core/images/icons_paths.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/feature/controller/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/feature/view/screens/profile_screens/profile_screen.dart';
import 'package:ecommerce_app/feature/view/screens/wishlist_screens/wishlist_screen.dart';
import 'package:ecommerce_app/feature/view/screens/cart_screens/cart_screen.dart';
import 'package:ecommerce_app/feature/view/widgets/category_widget.dart/categories_tab.dart';
import 'package:ecommerce_app/feature/view/widgets/home_widgets/home_screen_app_bar.dart';
import 'package:ecommerce_app/feature/view/widgets/home_widgets/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, int>(
      builder: (context, currentIndex) {
        final TextEditingController _searchController = TextEditingController();
        List<Widget> tabs = [
          const HomeTab(),
          const CategoriesTab(),
          const WishlistScreen(),
          const ProfileScreen(),
        ];

        return Scaffold(
          appBar: currentIndex == 0 
            ? PreferredSize(
                preferredSize: const Size.fromHeight(130),
                child: AppBar(
                  surfaceTintColor: Colors.white,
                  automaticallyImplyLeading: false,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(60),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          const Text(
                            'Welcome to Depi!',
                            style: TextStyle(
                              color: ColorManager.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => CartScreen()),
                              );
                            },
                            icon: const ImageIcon(
                              AssetImage(IconsPaths.cart),
                              color: ColorManager.primary,
                            ),
                            tooltip: 'Go to cart',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : null,
          extendBody: false,
          body: SafeArea(
            child: tabs[currentIndex],
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(15),
              topEnd: Radius.circular(15),
            ),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.1,
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (value) => context.read<HomeCubit>().changeSelectedIndex(value),
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
      },
    );
  }
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