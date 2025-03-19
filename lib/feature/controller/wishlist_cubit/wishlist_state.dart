part of 'wishlist_cubit.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistSuccess extends WishlistState {}

class WishlistError extends WishlistState {
  final String message;
  WishlistError(this.message);
}
