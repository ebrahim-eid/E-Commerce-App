import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/constants/constant.dart';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_states.dart';
import 'package:ecommerce_app/feature/model/cart_models/add_product_to_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(context) => BlocProvider.of(context);

  CartModel? cartModel;

  /// get cart data
  Future<void> getCartData() async {
    emit(GetCartLoadingState());
    try {
      String? token = CashHelper.getToken();
      if (token == null) {
        emit(GetCartErrorState('No token found'));
        return;
      }

      final response = await DioHelper().getData(
        url: AppConstants.addToCartEndPoint,
        token: token,
      );

      cartModel = CartModel.fromJson(response.data);
      emit(GetCartSuccessState());
    } catch (error) {
      emit(GetCartErrorState(error.toString()));
    }
  }

  /// add product to cart
  void addProductToCart({
    required String productId,
    required String token
  }) async {
    emit(AddToCartLoadingState());
    try {
      final response = await DioHelper().postData(
        url: AppConstants.addToCartEndPoint,
        data: {
          "productId": productId
        },
        token: token
      );
      
      cartModel = CartModel.fromJson(response.data);
      emit(AddToCartSuccessState());
    } on DioException catch (error) {
      if (error.response != null && error.response!.statusCode! >= 401) {
        emit(AddToCartErrorState(error.response?.data['message'] ?? 'Error adding to cart'));
      } else {
        emit(AddToCartErrorState(error.toString()));
      }
    } catch (error) {
      emit(AddToCartErrorState(error.toString()));
    }
  }

  /// update cart item quantity
  void updateCartItemQuantity({
    required String productId,
    required int count,
    required String token
  }) async {
    emit(UpdateCartItemLoadingState());
    try {
      final response = await DioHelper().putData(
        url: AppConstants.updateCartItemEndPoint(productId),
        data: {
          "count": count.toString()
        },
        token: token
      );
      
      cartModel = CartModel.fromJson(response.data);
      emit(UpdateCartItemSuccessState());
    } on DioException catch (error) {
      if (error.response != null && error.response!.statusCode! >= 401) {
        emit(UpdateCartItemErrorState(error.response?.data['message'] ?? 'Error updating cart'));
      } else {
        emit(UpdateCartItemErrorState(error.toString()));
      }
    } catch (error) {
      emit(UpdateCartItemErrorState(error.toString()));
    }
  }

  /// remove specific cart item
  void removeSpecificCartItem({
    required String id,
    required String token
  }) async {
    emit(RemoveSpecificItemLoadingState());
    try {
      await DioHelper().deleteData(
        url: '${AppConstants.addToCartEndPoint}/$id',
        token: token
      );
      
      // Refresh cart data after removal
      await getCartData();
      emit(RemoveSpecificItemSuccessState());
    } on DioException catch (error) {
      if (error.response != null && error.response!.statusCode! >= 401) {
        emit(RemoveSpecificItemErrorState(error.response?.data['message'] ?? 'Error removing item'));
      } else {
        emit(RemoveSpecificItemErrorState(error.toString()));
      }
    } catch (error) {
      emit(RemoveSpecificItemErrorState(error.toString()));
    }
  }

  /// delete user cart
  void deleteUserCart(String token) async {
    emit(DeleteUserCartLoadingState());
    try {
      await DioHelper().deleteData(
        url: AppConstants.deleteUserCartEndPoint,
        token: token
      );
      
      cartModel = null;
      emit(DeleteUserCartSuccessState());
    } on DioException catch (error) {
      if (error.response != null && error.response!.statusCode! >= 401) {
        emit(DeleteUserCartErrorState(error.response?.data['message'] ?? 'Error deleting cart'));
      } else {
        emit(DeleteUserCartErrorState(error.toString()));
      }
    } catch (error) {
      emit(DeleteUserCartErrorState(error.toString()));
    }
  }
}
