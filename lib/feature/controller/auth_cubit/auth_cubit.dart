import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/constants/constant.dart';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_states.dart';


class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  /// sign up
  void signUp({
    required String name,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    emit(SignUpLoadingState());
    try {
      final response = await DioHelper().postData(
        url: AppConstants.registerEndPoint,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "rePassword": rePassword,
          "phone": phone,
        },
      );
      print(response.data);
      // String token=response.data['token'];
      emit(SignUpSuccessState());
    } on DioException catch (error) {
      if (error.response?.statusCode == 409) {
        print(error.response?.data['message']);
        emit(SignUpErrorState(error.response?.data['message']));
      } else {
        print(error.toString());
        emit(SignUpErrorState(error.toString()));
      }
    } catch (e) {
      print("Unexpected error: $e");
      emit(SignUpErrorState("Unexpected error: $e"));
    }
  }

  /// login 
  void loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      final response = await DioHelper().postData(
        url: AppConstants.loginEndPoint,
        data: {
          "email": email,
          "password": password,
        },
      );
      String token = response.data['token'];
      await CashHelper.saveToken(token);
      emit(LoginSuccessState());
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        emit(LoginErrorState(error.response?.data['message']));
      } else {
        emit(LoginErrorState(error.toString()));
      }
    } catch (error) {
      emit(LoginErrorState("Unexpected error: $error"));
    }
  }

  /// Forgot password
  void forgotPassword(String email) async{
    emit(ForgotPasswordLoadingState());
    await DioHelper().postData(url: AppConstants.forgotPasswordEndPoint, data: {
      "email":email
    }).then((value){
      print(value.data['message']);
      emit(ForgotPasswordSuccessState());
    }).catchError((error){
      if (error.response?.statusCode==404){
        print(error.response?.data['message']);
        emit(ForgotPasswordErrorState(error.response?.data['message']));
      } else {
        print(error.toString());
        emit(ForgotPasswordErrorState(error.toString()));
      }
    });
  }

/// verify reset code
  void verifyResetCode(String resetCode) async{
    emit(VerifyResetCodeLoadingState());
    await DioHelper().postData(url: AppConstants.verifyResetCodeEndPoint, data: {
      "resetCode":resetCode
    }).then((value){
      // if status == success then navigate to reset password screen
      print(value.data['status']);
      emit(VerifyResetCodeSuccessState());
    }).catchError((error){
      if (error.response?.statusCode==400){
        print(error.response?.data['message']);
        emit(VerifyResetCodeErrorState(error.response?.data['message']));
      } else {
        print(error.toString());
        emit(VerifyResetCodeErrorState(error.toString()));
      }
    });
  }

///resetPassword
  void resetPassword({
    required String email,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoadingState());
    await DioHelper().putData(url: AppConstants.resetPasswordEndPoint, data: {
      "email": email,
      "newPassword": newPassword
    }).then((value) {
      // if success then navigate to Home Screen Directly
      print(value.data['token']);
      emit(ResetPasswordSuccessState());
    }).catchError((error) {
      if (error.response?.statusCode == 400) {
        print(error.response?.data['message']);
        emit(ResetPasswordErrorState(error.response?.data['message']));
      } else {
        print(error.toString());
        emit(ResetPasswordErrorState(error.toString()));
      }
    });
  }
}

/// get all users and verify token
/// update logged user data