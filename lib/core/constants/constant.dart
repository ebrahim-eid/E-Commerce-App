class AppConstants {
  static String baseUrl = 'https://ecommerce.routemisr.com/api/v1/';
  static String loginEndPoint = 'auth/signin';
  static String registerEndPoint = 'auth/signup';
  static String forgotPasswordEndPoint = 'auth/forgotPasswords';
  static String verifyResetCodeEndPoint = 'auth/verifyResetCode';
  static String resetPasswordEndPoint = 'auth/resetPassword';
  static String getAllProductEndPoint = 'products';
  static String getProductByIdEndPoint(String id) => 'products/$id';
  static String addToCartEndPoint = 'cart';
  static String removeSpecificCartEndPoint(String id) => 'cart/$id';
  static String deleteUserCartEndPoint = 'cart';
  static const String updateProfileEndPoint = 'users/updateMe';
  static const String getProfileEndPoint = 'users/me';
}
