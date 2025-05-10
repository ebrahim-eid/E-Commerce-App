import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';
import 'package:ecommerce_app/core/constants/constant.dart';
import 'package:dio/dio.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  final _dioHelper = DioHelper();

  Map<String, dynamic> userData = {};

  Future<void> getUserProfile() async {
    emit(ProfileLoadingState());
    try {
      // Get saved user data from local storage
      final name = CashHelper.getData(key: 'userName');
      final email = CashHelper.getData(key: 'userEmail');
      final phone = CashHelper.getPhone();

      if (name != null && email != null) {
        userData = {
          'name': name,
          'email': email,
          if (phone != null) 'phone': phone,
        };
        emit(ProfileSuccessState(userData: userData));
      } else {
        emit(ProfileErrorState(error: 'No user data available'));
      }
    } catch (error) {
      emit(ProfileErrorState(error: error.toString()));
    }
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
  }) async {
    emit(UpdateProfileLoadingState());
    try {
      // Get token from storage
      final token = CashHelper.getData(key: 'token');
      if (token == null) {
        emit(UpdateProfileErrorState(error: 'Authentication token not found'));
        return;
      }

      // Create data map with only the field that was updated
      final Map<String, dynamic> data = {};
      if (name != null) data['name'] = name;
      if (email != null) data['email'] = email;
      if (phone != null) data['phone'] = phone;

      // If no data to update, return
      if (data.isEmpty) {
        emit(UpdateProfileErrorState(error: 'No data to update'));
        return;
      }

      final response = await _dioHelper.putData(
        url: '${AppConstants.updateProfileEndPoint}/',
        data: data,
        token: token,
      );

      if (response.statusCode == 200) {
        // Update local storage with new data
        if (name != null) await CashHelper.setData(key: 'userName', value: name);
        if (email != null) await CashHelper.setData(key: 'userEmail', value: email);
        if (phone != null) await CashHelper.savePhone(phone);

        // Update userData with new values
        userData.addAll(data);
        emit(UpdateProfileSuccessState(userData: userData));
      } else {
        emit(UpdateProfileErrorState(error: 'Failed to update profile'));
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to update profile';
      
      if (e.response?.statusCode == 400) {
        if (e.response?.data['email'] != null) {
          errorMessage = 'This email is already in use';
        } else if (e.response?.data['phone'] != null) {
          errorMessage = 'This phone number is already in use';
        }
      }
      
      emit(UpdateProfileErrorState(error: errorMessage));
    } catch (error) {
      emit(UpdateProfileErrorState(error: error.toString()));
    }
  }
} 