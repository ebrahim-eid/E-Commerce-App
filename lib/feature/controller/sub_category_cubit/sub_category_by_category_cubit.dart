import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/feature/controller/sub_category_cubit/sub_category_by_category_state.dart';
import 'package:ecommerce_app/feature/model/sub_category_model/sub_category_repository.dart';



class SubCategoryCubit extends Cubit<SubCategoryByCategoryState> {
  final SubCategoryRepository repository;

  SubCategoryCubit({required this.repository}) : super(SubCategoryInitial());

  Future<void> fetchSubCategoriesByCategory(String categoryId) async {
    emit(SubCategoryLoading());
    try {
      final subCategories = await repository.getSubCategoriesByCategory(categoryId);
      emit(SubCategoryLoaded(subCategories));
    } catch (error) {
      emit(SubCategoryError(error.toString()));
    }
  }
}
