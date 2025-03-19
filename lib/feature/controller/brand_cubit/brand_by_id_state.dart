part of 'brand_by_id_cubit.dart';

abstract class BrandByIdState {}

class BrandByIdInitial extends BrandByIdState {}

class BrandByIdLoading extends BrandByIdState {}

class BrandByIdLoaded extends BrandByIdState {
  final BrandModel brand;
  BrandByIdLoaded(this.brand);
}

class BrandByIdError extends BrandByIdState {
  final String message;
  BrandByIdError(this.message);
}
