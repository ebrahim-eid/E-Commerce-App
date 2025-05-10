import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/controller/category_cubit/category_cubit.dart';
import 'package:ecommerce_app/feature/controller/sub_category_cubit/sub_category_cubit.dart';
import 'package:ecommerce_app/feature/view/widgets/category_widget.dart/category_text_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.containerGray,
          border: BorderDirectional(
            top: BorderSide(
              width: Sizes.s2,
              color: ColorManager.primary.withOpacity(0.3),
            ),
            start: BorderSide(
              width: Sizes.s2,
              color: ColorManager.primary.withOpacity(0.3),
            ),
            bottom: BorderSide(
              width: Sizes.s2,
              color: ColorManager.primary.withOpacity(0.3),
            ),
          ),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(Sizes.s12),
            bottomStart: Radius.circular(Sizes.s12),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(Sizes.s12),
            bottomStart: Radius.circular(Sizes.s12),
          ),
          child: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoriesLoaded) {
                return ListView.builder(
                  itemCount: state.categories.length,
                  itemBuilder: (_, index) => CategoryTextItem(
                    index,
                    state.categories[index].name,
                    _selectedIndex == index,
                    onItemClick,
                  ),
                );
              } else if (state is CategoriesError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  void onItemClick(int index) {
    setState(() => _selectedIndex = index);
    final state = context.read<CategoriesCubit>().state;
    if (state is CategoriesLoaded) {
      final categoryId = state.categories[index].id;
      context.read<SubCategoryCubit>().fetchSubCategoriesByCategory(categoryId);
    }
  }
}
