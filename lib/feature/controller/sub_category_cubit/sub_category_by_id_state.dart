
import 'package:ecommerce_app/feature/model/sub_category_model/sub_category_model.dart';

abstract class SubCategoryByIdState {}

class SubCategoryByIdInitial extends SubCategoryByIdState {}

class SubCategoryByIdLoading extends SubCategoryByIdState {}

class SubCategoryByIdLoaded extends SubCategoryByIdState {
  final SubCategoryModel subCategory;
  SubCategoryByIdLoaded(this.subCategory);
}

class SubCategoryByIdError extends SubCategoryByIdState {
  final String message;
  SubCategoryByIdError(this.message);
}
