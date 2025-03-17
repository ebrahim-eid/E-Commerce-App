import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/feature/controller/category_cubit/category_by_id_state.dart';
import 'package:ecommerce_app/feature/model/categories_model/category_repository.dart';

class CategoryByIdCubit extends Cubit<CategoryByIdState> {
  final CategoryRepository categoryRepository;

  CategoryByIdCubit(this.categoryRepository) : super(CategoryByIdInitial());

  void fetchCategoryById(String categoryId) async {
    emit(CategoryByIdLoading());
    try {
      final category = await categoryRepository.getCategoryById(categoryId);
      emit(CategoryByIdLoaded(category));
    } catch (e) {
      emit(CategoryByIdError(e.toString()));
    }
  }
}
