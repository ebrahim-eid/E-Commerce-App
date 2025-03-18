import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';
import 'package:ecommerce_app/feature/model/categories_model/category_model.dart';


class CategoryRepository {
  final DioHelper dioHelper;

  CategoryRepository(this.dioHelper);

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      Response response = await dioHelper.getData(url: 'categories');
      List<dynamic> categoriesJson = response.data['data'];
      return categoriesJson.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
   Future<CategoryModel> getCategoryById(String categoryId) async {
    try {
      Response response = await dioHelper.getData(
        url: '/categories/$categoryId',
      );
      return CategoryModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to load category: $e');
    }
  }
}
