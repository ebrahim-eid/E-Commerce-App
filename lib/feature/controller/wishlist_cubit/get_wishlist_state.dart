part of 'get_wishlist_cubit.dart';

abstract class GetWishlistState {}

class GetWishlistInitial extends GetWishlistState {}

class GetWishlistLoading extends GetWishlistState {}

class GetWishlistLoaded extends GetWishlistState {
  final List<WishlistModel> wishlist;
  GetWishlistLoaded(this.wishlist);
}

class GetWishlistError extends GetWishlistState {
  final String message;
  GetWishlistError(this.message);
}
