import 'package:ecommerce_app/core/constants/constant.dart';
import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';
import 'package:ecommerce_app/feature/controller/product_cubit/product_states.dart';
import 'package:ecommerce_app/feature/model/all_products_model/all_products_model.dart';
import 'package:ecommerce_app/feature/model/all_products_model/single_product_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);

  /// get all products
  AllProductModel ? allProductModel;
  void getAllProducts()async{
    emit(ProductLoadingState());
   await DioHelper().getData(url: AppConstants.getAllProductEndPoint).then((value){
     allProductModel = AllProductModel.fromJson(value.data);
     print("*********************************${allProductModel!.data[1].description}");
     emit(ProductSuccessState());
    }).catchError((error){
      print(error);
      emit(ProductErrorState(error.toString()));
   });
  }


  /// get product by id
  SingleProductDataModel ? singleProductDataModel;
  void getProductById(String id)async{
    emit(ProductByIdLoadingState());
    await DioHelper().getData(url: AppConstants.getProductByIdEndPoint(id)).then((value){
      singleProductDataModel = SingleProductDataModel.fromJson(value.data);
      print("*********************************${singleProductDataModel!.quantity}");
      emit(ProductByIdSuccessState());
    }).catchError((error){
      print(error);
      emit(ProductByIdErrorState(error.toString()));
    });
  }
}
