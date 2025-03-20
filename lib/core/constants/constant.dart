class AppConstants {
  static String baseUrl = 'https://ecommerce.routemisr.com/api/v1/';
<<<<<<< HEAD
  static String loginEndPoint = 'login';
  static String registerEndPoint = 'register';
  static String homeEndPoint = 'home';
  static String categoriesEndPoint = 'categories';
  static String favoriteEndPoint = 'favorites';
  static String profileEndPoint = 'profile';
  static String updateProfileEndPoint = 'update-profile';
  static String searchEndPoint = 'products/search';
=======
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


>>>>>>> ibrahim
}
