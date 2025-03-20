import 'package:ecommerce_app/feature/model/categories_model/category_model.dart';

abstract class CategoryByIdState {}

class CategoryByIdInitial extends CategoryByIdState {}
class CategoryByIdLoading extends CategoryByIdState {}
class CategoryByIdLoaded extends CategoryByIdState {
  final CategoryModel category;
  CategoryByIdLoaded(this.category);
}
class CategoryByIdError extends CategoryByIdState {
  final String message;
  CategoryByIdError(this.message);
}