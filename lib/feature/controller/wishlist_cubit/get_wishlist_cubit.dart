import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/feature/model/wishlist_model/wishlist_model.dart';
import 'package:ecommerce_app/feature/model/wishlist_model/wishlist_repository.dart';

part 'get_wishlist_state.dart';

class GetWishlistCubit extends Cubit<GetWishlistState> {
  final WishlistApi wishlistRepository;

  GetWishlistCubit(this.wishlistRepository) : super(GetWishlistInitial());

  List<WishlistModel> wishlist = [];

  /// Fetch wishlist
  Future<void> getWishlist(String token) async {
    emit(GetWishlistLoading());
    try {
      wishlist = await wishlistRepository.getWishlist(token);
      emit(GetWishlistLoaded(wishlist));
    } catch (e) {
      emit(GetWishlistError(e.toString()));
    }
  }

}
