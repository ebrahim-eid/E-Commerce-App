import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      await sharedPreferences.setString(key, value);
      return true;
    }
    if (value is int) {
      await sharedPreferences.setInt(key, value);
      return true;
    }
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
      return true;
    }
    return false;
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future clearData(String key) async{
    return await sharedPreferences.remove(key);
  }

  static Future<bool> saveToken(String token) async {
    return await sharedPreferences.setString('token', token);
  }

  static String? getToken() {
    return sharedPreferences.getString('token');
  }

  static Future<bool> removeToken() async {
    return await sharedPreferences.remove('token');
  }

  static Future<bool> savePhone(String phone) async {
    return await sharedPreferences.setString('phone', phone);
  }

  static String? getPhone() {
    return sharedPreferences.getString('phone');
  }

  static Future<bool> removePhone() async {
    return await sharedPreferences.remove('phone');
  }
}
