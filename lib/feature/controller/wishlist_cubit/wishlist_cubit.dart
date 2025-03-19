import 'package:ecommerce_app/feature/model/wishlist_model/wishlist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistApi wishlistApi;

  WishlistCubit(this.wishlistApi) : super(WishlistInitial());

  Future<void> addProductToWishlist(String productId, String token) async {
    emit(WishlistLoading());
    try {
      await wishlistApi.addToWishlist(productId, token);
      emit(WishlistSuccess());
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }
  Future<void> removeProductFromWishlist(String productId, String token) async {
    emit(WishlistLoading());
    try {
      await wishlistApi.removeFromWishlist(productId, token);
      emit(WishlistSuccess());
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }
}
