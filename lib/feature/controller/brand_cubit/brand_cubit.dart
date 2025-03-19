import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/feature/model/brand_model/brand_model.dart';
import 'package:ecommerce_app/feature/model/brand_model/brand_repository.dart';


part 'brand_state.dart';

class BrandsCubit extends Cubit<BrandsState> {
  final BrandsApi _brandsApi;

  BrandsCubit(this._brandsApi) : super(BrandsInitial());

  Future<void> fetchBrands() async {
    emit(BrandsLoading());
    try {
      List<BrandModel> brands = await _brandsApi.getAllBrands();
      emit(BrandsLoaded(brands));
    } catch (e) {
      emit(BrandsError(e.toString()));
    }
  }
}
