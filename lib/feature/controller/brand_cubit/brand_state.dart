part of 'brand_cubit.dart';


abstract class BrandsState {}

class BrandsInitial extends BrandsState {}

class BrandsLoading extends BrandsState {}

class BrandsLoaded extends BrandsState {
  final List<BrandModel> brands;
  BrandsLoaded(this.brands);
}

class BrandsError extends BrandsState {
  final String message;
  BrandsError(this.message);
}
