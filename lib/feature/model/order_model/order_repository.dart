import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';
import 'package:ecommerce_app/feature/model/order_model/order_model.dart';
import 'package:ecommerce_app/feature/model/order_model/user_order_model.dart';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';

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
      final token = CashHelper.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      print('Fetching orders for user $userId with token'); // Debug print
      final response = await dioHelper.getData(
        url: 'orders/user/$userId',
        token: token,
      );

      print("API Response: ${response.data}"); // Debug print

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;

        // Handle both array and object with data property
        List<dynamic> ordersList;
        if (data is List) {
          ordersList = data;
        } else if (data is Map && data.containsKey('data')) {
          ordersList = data['data'] as List;
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }

        return ordersList
            .where((order) => order is Map<String, dynamic>) // Filter valid maps
            .map((order) => UserOrderModel.fromJson(order as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getUserOrders: $e'); // Debug print
      throw Exception('Error fetching orders: $e');
    }
  }
}
