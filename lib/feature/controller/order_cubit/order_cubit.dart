import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/feature/model/order_model/order_repository.dart';


part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;

  OrderCubit(this.orderRepository) : super(OrderInitial());

  /// Create Cash Order
  Future<void> createCashOrder({
    required String userId,
    required Map<String, dynamic> shippingAddress,
    required String token,
  }) async {
    emit(OrderLoading());
    try {
      await orderRepository.createCashOrder(
        userId: userId,
        shippingAddress: shippingAddress,
        token: token,
      );
      emit(OrderSuccess());
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
