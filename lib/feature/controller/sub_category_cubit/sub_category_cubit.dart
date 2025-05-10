import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/feature/model/sub_category_model/sub_category_model.dart';
import 'package:ecommerce_app/feature/model/sub_category_model/sub_category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'sub_category_state.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  final SubCategoryRepository repository;

  SubCategoryCubit(this.repository) : super(SubCategoryInitial());

  void fetchSubCategories() async {
    emit(SubCategoryLoading());
    try {
      final subCategories = await repository.fetchSubCategories();
      emit(SubCategorySuccess(subCategories));
    } catch (e) {
      emit(SubCategoryError(e.toString()));
    }
  }

  void fetchSubCategoriesByCategory(String categoryId) async {
    emit(SubCategoryLoading());
    try {
      final subCategories = await repository.getSubCategoriesByCategory(categoryId);
      emit(SubCategorySuccess(subCategories));
    } catch (e) {
      emit(SubCategoryError(e.toString()));
    }
  }
}
