import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/feature/model/shipping_address_model.dart';

part 'shipping_address_state.dart';

class ShippingAddressCubit extends Cubit<ShippingAddressState> {
  ShippingAddressCubit() : super(ShippingAddressInitial());

  List<ShippingAddress> addresses = [];

  Future<void> loadAddresses() async {
    emit(ShippingAddressLoading());
    try {
      addresses = await ShippingAddressManager.getAddresses();
      emit(ShippingAddressLoaded(addresses));
    } catch (e) {
      emit(ShippingAddressError(e.toString()));
    }
  }

  Future<void> addAddress(ShippingAddress address) async {
    emit(ShippingAddressLoading());
    try {
      await ShippingAddressManager.addAddress(address);
      addresses.add(address);
      emit(ShippingAddressLoaded(addresses));
    } catch (e) {
      emit(ShippingAddressError(e.toString()));
    }
  }

  Future<void> updateAddress(int index, ShippingAddress address) async {
    emit(ShippingAddressLoading());
    try {
      await ShippingAddressManager.updateAddress(index, address);
      addresses[index] = address;
      emit(ShippingAddressLoaded(addresses));
    } catch (e) {
      emit(ShippingAddressError(e.toString()));
    }
  }

  Future<void> deleteAddress(int index) async {
    emit(ShippingAddressLoading());
    try {
      await ShippingAddressManager.deleteAddress(index);
      addresses.removeAt(index);
      emit(ShippingAddressLoaded(addresses));
    } catch (e) {
      emit(ShippingAddressError(e.toString()));
    }
  }
} 