import 'package:ecommerce_app/feature/model/brand_model/brand_model.dart';
import 'package:ecommerce_app/feature/model/brand_model/brand_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'brand_by_id_state.dart';

class BrandCubit extends Cubit<BrandByIdState> {
  final BrandsApi brandsApi;

  BrandCubit(this.brandsApi) : super(BrandByIdInitial());

  Future<void> fetchBrandById(String brandId) async {
    emit(BrandByIdLoading());
    try {
      final brand = await brandsApi.getBrandById(brandId);
      emit(BrandByIdLoaded(brand));
    } catch (e) {
      emit(BrandByIdError(e.toString()));
    }
  }
}
