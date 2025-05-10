import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/images/icons_paths.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/view/screens/cart_screens/cart_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? automaticallyImplyLeading;
  final bool showSearch;
  const HomeScreenAppBar({
    super.key, 
    this.automaticallyImplyLeading,
    this.showSearch = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      bottom: showSearch ? PreferredSize(
        preferredSize: Size(Sizes.s100, Sizes.s60),
        child: Padding(
          padding: EdgeInsets.all(Insets.s8),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  cursorColor: ColorManager.primary,
                  style: getRegularStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s16,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: Insets.s12,
                      vertical: Insets.s8,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10000),
                      borderSide: const BorderSide(
                        width: Sizes.s1,
                        color: ColorManager.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10000),
                      borderSide: const BorderSide(
                        width: Sizes.s1,
                        color: ColorManager.primary,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10000),
                      borderSide: const BorderSide(
                        width: Sizes.s1,
                        color: ColorManager.primary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10000),
                      borderSide: const BorderSide(
                        width: Sizes.s1,
                        color: ColorManager.primary,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10000),
                      borderSide: const BorderSide(
                        width: Sizes.s1,
                        color: ColorManager.error,
                      ),
                    ),
                    prefixIcon: const ImageIcon(
                      AssetImage(IconsPaths.search),
                      color: ColorManager.primary,
                    ),
                    hintText: 'what do you search for?',
                    hintStyle: getRegularStyle(
                      color: ColorManager.primary,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => HelperFunctions.navigateTo(context, CartScreen()),
                icon: const ImageIcon(
                  AssetImage(IconsPaths.cart),
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
        ),
      ) : null,
    );
  }

  @override
  Size get preferredSize => Size(0, showSearch ? 130 : 60);
}
