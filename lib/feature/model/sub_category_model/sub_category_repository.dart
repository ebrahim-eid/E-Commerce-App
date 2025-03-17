

import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';
import 'package:ecommerce_app/feature/model/sub_category_model/sub_category_model.dart';

class SubCategoryRepository {
  final DioHelper dioHelper=DioHelper();
  Future<List<SubCategoryModel>> fetchSubCategories() async {
    try {
      final response = await dioHelper.getData(url: 'subcategories');
      final List<dynamic> data = response.data['data'];
      return data.map((json) => SubCategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load subcategories: $e');
    }
  }
  Future<SubCategoryModel?> getSubCategory(String id) async {
    try {
      final response = await dioHelper.getData(url: 'subcategories/$id');

      if (response.data != null && response.data['data'] != null) {
        return SubCategoryModel.fromJson(response.data['data']);
      }
      return null;
    } catch (error) {
      print('API Error: $error');
      return null;
    }
  }
  Future<List<SubCategoryModel>> getSubCategoriesByCategory(String categoryId) async {
    try {
      final response = await dioHelper.getData(
        url: 'categories/$categoryId/subcategories',
      );
      return SubCategoryModel.fromJsonList(response.data['data']);
    } catch (error) {
      throw Exception("Failed to load subcategories: $error");
    }
  }
}
