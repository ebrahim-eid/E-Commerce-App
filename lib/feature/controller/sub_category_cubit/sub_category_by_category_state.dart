import 'package:ecommerce_app/feature/model/sub_category_model/sub_category_model.dart';

abstract class SubCategoryByCategoryState {}

class SubCategoryInitial extends SubCategoryByCategoryState {}

class SubCategoryLoading extends SubCategoryByCategoryState {}

class SubCategoryLoaded extends SubCategoryByCategoryState {
  final List<SubCategoryModel> subCategory;
  SubCategoryLoaded(this.subCategory);
}

class SubCategoryByCategoryLoaded extends SubCategoryByCategoryState {
  final List<SubCategoryModel> subCategories;
  SubCategoryByCategoryLoaded(this.subCategories);
}

class SubCategoryError extends SubCategoryByCategoryState {
  final String error;
  SubCategoryError(this.error);
}