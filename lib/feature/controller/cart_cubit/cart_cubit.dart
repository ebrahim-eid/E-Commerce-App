import 'package:ecommerce_app/core/constants/constant.dart';
import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_states.dart';
import 'package:ecommerce_app/feature/model/cart_models/add_product_to_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(context) => BlocProvider.of(context);

  /// add product to cart
  CartModel ? cartModel;
  void addProductToCart({
    required String productId,
    required String token
}) async {
    emit(AddToCartLoadingState());
    await DioHelper().postData(
        url: AppConstants.addToCartEndPoint,
        data: {
          "productId":productId
        },
        // you can get the token from shared pref
        token: token).then((value){
          cartModel =CartModel.fromJson(value.data);
          print(cartModel!.message);
      emit(AddToCartSuccessState());
    }).catchError((error){
      if (error.response?.statusCode >=401){
        print(error.response?.data['message']);
        emit(AddToCartErrorState(error.response?.data['message']));
      } else {
        print(error.toString());
        emit(AddToCartErrorState(error.toString()));
      }
    });
  }

  /// remove specific cart item
  void removeSpecificCartItem({
    required String id,
    required String token
  }) async {
    emit(RemoveSpecificItemLoadingState());
    await DioHelper().deleteData(
        url: AppConstants.removeSpecificCartEndPoint(id),
        // you can get the token from shared pref
        token: token).then((value){
      emit(RemoveSpecificItemSuccessState());
    }).catchError((error){
      if (error.response?.statusCode >=401){
        print(error.response?.data['message']);
        emit(RemoveSpecificItemErrorState(error.response?.data['message']));
      } else {
        print(error.toString());
        emit(RemoveSpecificItemErrorState(error.toString()));
      }
    });
  }

  /// delete user cart
  void deleteUserCart(String token)async{
    emit(DeleteUserCartLoadingState());
    await DioHelper().deleteData(
        url: AppConstants.deleteUserCartEndPoint,
        token: token).then((value){
      emit(DeleteUserCartSuccessState());
    }).catchError((error){
      if (error.response?.statusCode >=401){
        print(error.response?.data['message']);
        emit(DeleteUserCartErrorState(error.response?.data['message']));
      } else {
        print(error.toString());
        emit(DeleteUserCartErrorState(error.toString()));
      }
    });
  }
}
