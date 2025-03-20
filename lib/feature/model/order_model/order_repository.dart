
import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';
import 'package:ecommerce_app/feature/model/order_model/order_model.dart';
import 'package:ecommerce_app/feature/model/order_model/user_order_model.dart';

class OrderRepository {
  final DioHelper dioHelper;

  OrderRepository({required this.dioHelper});

  /// Create a cash order
  Future<void> createCashOrder({
    required String userId,
    required Map<String, dynamic> shippingAddress,
    required String token,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: '/orders/$userId',
        data: {"shippingAddress": shippingAddress},
        token: token,
      );

      if (response.statusCode != 201) {
        throw Exception("Failed to create order");
      }
    } catch (e) {
      throw Exception("Error creating order: $e");
    }
  }


  Future<List<OrderModel>> getAllOrders() async {
    try {
      final response = await dioHelper.getData(url: 'orders/');
      List<OrderModel> orders = (response.data['data'] as List)
          .map((order) => OrderModel.fromJson(order))
          .toList();
      return orders;
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }

  Future<List<UserOrderModel>> getUserOrders(String userId) async {
    try {
      final response = await dioHelper.getData(
        url: 'orders/user/$userId',
      );

      print("API Response: ${response.data}"); // Debugging

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;

        // Ensure response is a List
        if (data is List) {
          return data
              .where((order) => order is Map<String, dynamic>) // Filter valid maps
              .map((order) => UserOrderModel.fromJson(order as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }
}
