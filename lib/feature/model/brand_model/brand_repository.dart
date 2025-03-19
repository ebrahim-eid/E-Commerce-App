

import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';
import 'package:ecommerce_app/feature/model/brand_model/brand_model.dart';

class BrandsApi {
  final DioHelper dioHelper=DioHelper();
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final response = await dioHelper.getData(url: "brands");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((brand) => BrandModel.fromJson(brand)).toList();
      } else {
        throw Exception("Failed to load brands");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
  Future<BrandModel> getBrandById(String brandId) async {
    try {
      final response = await dioHelper.getData(url: "brands/$brandId");
      if (response.statusCode == 200) {
        return BrandModel.fromJson(response.data["data"]);
      } else {
        throw Exception("Failed to load brand");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
