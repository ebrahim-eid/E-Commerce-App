part of 'sub_category_cubit.dart';

abstract class SubCategoryState {}

class SubCategoryInitial extends SubCategoryState {}

class SubCategoryLoading extends SubCategoryState {}

class SubCategorySuccess extends SubCategoryState {
  final List<SubCategoryModel> subCategories;
  SubCategorySuccess(this.subCategories);
}

class SubCategoryError extends SubCategoryState {
  final String error;
  SubCategoryError(this.error);
}
