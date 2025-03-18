import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/feature/model/sub_category_model/sub_category_repository.dart';

import 'sub_category_by_id_state.dart';


class SubCategoryByIdCubit extends Cubit<SubCategoryByIdState> {
  final SubCategoryRepository subCategoryRepository;

  SubCategoryByIdCubit(this.subCategoryRepository) : super(SubCategoryByIdInitial());

  void fetchSubCategory(String id) async {
    emit(SubCategoryByIdLoading());

    try {
      final subCategory = await subCategoryRepository.getSubCategory(id);
      if (subCategory != null) {
        emit(SubCategoryByIdLoaded(subCategory));
      } else {
        emit(SubCategoryByIdError("Failed to fetch subcategory"));
      }
    } catch (e) {
      emit(SubCategoryByIdError(e.toString()));
    }
  }
}
