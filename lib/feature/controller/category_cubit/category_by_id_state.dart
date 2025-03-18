import 'package:ecommerce_app/feature/model/categories_model/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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