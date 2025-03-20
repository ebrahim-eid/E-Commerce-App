import '../../constants/constant.dart';
import 'package:dio/dio.dart';

class DioHelper{
    Dio ? dio;
    DioHelper() {
      init();
    }
   /// init
  void init(){
    dio= Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        receiveDataWhenStatusError: true,
      ));
  }

  /// get data
   Future<Response>getData({
     required String url,
    Map<String, dynamic> ? query,
    String ? token,
}) async{
    dio!.options.headers=  {
      'Content-Type':'application/json',
      'lang':'en',
      'Authorization': token ?? ''
    };
    return await dio!.get(url,queryParameters: query);
  }

  /// post data
   Future<Response>postData({
    required String url,
    required Map<String, dynamic> data,
    String ?token,

  }) async{
     dio!.options.headers=  {
       'Content-Type':'application/json',
       'token': token ?? ''
     };
    final response= await dio!.post(url,data: data);
     if (response.statusCode! >= 401) {
       throw DioException(
         requestOptions: response.requestOptions,
         response: response,
         type: DioExceptionType.badResponse,
       );
     }
    return response;
  }

    Future<Response>putData({
     required String url,
     required Map<String, dynamic> data,
   }) async{
     final response= await dio!.put(url,data: data);
     if (response.statusCode != 200) {
       throw DioException(
         requestOptions: response.requestOptions,
         response: response,
         type: DioExceptionType.badResponse,
       );
     }
     return response;
   }
<<<<<<< HEAD
   Future<Response> deleteData({
     required String url,
     String? token,
   }) async {
     dio!.options.headers = {
       'Content-Type': 'application/json',
       'lang': 'en',
       'Authorization': token ?? '',
     };

     final response = await dio!.delete(url);

     if (response.statusCode != 200) {
       throw DioException(
         requestOptions: response.requestOptions,
         response: response,
         type: DioExceptionType.badResponse,
       );
     }
     return response;
   }
}
=======


    Future<Response> deleteData({
      required String url,
      String? token,
    }) async {
      dio!.options.headers = {
        'Content-Type': 'application/json',
        'token': token ?? '',
      };

      final response = await dio!.delete(url);

      if (response.statusCode! >= 401) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
      return response;
    }
}

>>>>>>> ibrahim
