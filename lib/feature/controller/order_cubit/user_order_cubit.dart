import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/feature/model/order_model/order_model.dart';
import 'package:ecommerce_app/feature/model/order_model/order_repository.dart';
import 'package:ecommerce_app/feature/model/order_model/user_order_model.dart';

part 'user_order_state.dart';

class UserOrderCubit extends Cubit<UserOrderState> {
  final OrderRepository orderRepository;

  UserOrderCubit(this.orderRepository) : super(UserOrderInitial());

  Future<void> getUserOrders(String userId) async {
    emit(UserOrderLoading());

    try {
      final orders = await orderRepository.getUserOrders(userId);
      emit(UserOrderLoaded(orders));
    } catch (e) {
      emit(UserOrderError('Error fetching orders: $e'));
    }
  }
}
