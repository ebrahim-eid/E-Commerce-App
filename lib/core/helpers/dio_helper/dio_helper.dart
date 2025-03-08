import '../../constants/constant.dart';
import 'package:dio/dio.dart';

class DioHelper{
   static Dio ? dio;

   /// init
  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type':'application/json',
          'lang':'ar',
        },
      ));
  }

  /// get data
  static Future<Response>getData({
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
  static Future<Response>postData({
    required String url,
    required Map<String, dynamic> data,
    String ?token,

  }) async{
    final response= await dio!.post(url,data: data);
    if (response.statusCode != 200) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
    dio!.options.headers=  {
      'Content-Type':'application/json',
      'lang':'en',
      'Authorization': token ?? ''
    };
    return response;
  }

   static Future<Response>putData({
     required String url,
     required Map<String, dynamic> data,
     String ?token
   }) async{
     final response= await dio!.put(url,data: data);
     if (response.statusCode != 200) {
       throw DioException(
         requestOptions: response.requestOptions,
         response: response,
         type: DioExceptionType.badResponse,
       );
     }
     dio!.options.headers=  {
       'Content-Type':'application/json',
       'lang':'en',
       'Authorization': token ?? ''
     };
     return response;
   }
}