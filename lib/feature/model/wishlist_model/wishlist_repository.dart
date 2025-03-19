
import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';
import 'package:ecommerce_app/feature/model/wishlist_model/wishlist_model.dart';

class WishlistApi {
  final DioHelper dioHelper=DioHelper();
  Future<void> addToWishlist(String productId, String token) async {
    try {
      final response = await dioHelper.postData(
        url: "wishlist",
        data: {
          "productId": productId,
        },
        token: token,
      );

      if (response.statusCode == 200) {
        print("Product added to wishlist successfully.");
      } else {
        throw Exception("Failed to add product to wishlist");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<void> removeFromWishlist(String productId, String token) async {
    try {
      final response = await dioHelper.deleteData(
        url: "wishlist/$productId",
        token: token,
      );

      if (response.statusCode == 200) {
        print("Product removed from wishlist successfully.");
      } else {
        throw Exception("Failed to remove product from wishlist");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<WishlistModel>> getWishlist(String token) async {
    try {
      final response = await dioHelper.getData(
        url: '/wishlist',
        token: token,
      );

      final List<dynamic> wishlistData = response.data['data'];
      return wishlistData.map((item) => WishlistModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception("Failed to fetch wishlist: $e");
    }
  }
}
