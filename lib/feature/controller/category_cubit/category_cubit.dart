
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/feature/model/categories_model/category_model.dart';
import 'package:ecommerce_app/feature/model/categories_model/category_repository.dart';
part 'category_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoryRepository categoryRepository;

  CategoriesCubit(this.categoryRepository) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    try {
      final categories = await categoryRepository.getAllCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError("Failed to load categories"));
    }
  }
}
