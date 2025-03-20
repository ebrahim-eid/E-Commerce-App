import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/feature/model/order_model/order_model.dart';
import 'package:ecommerce_app/feature/model/order_model/order_repository.dart';


part 'get_all_orders_state.dart';

class OrderCubit extends Cubit<GetAllOrdersState> {
  final OrderRepository orderRepository;

  OrderCubit(this.orderRepository) : super(GetAllOrdersInitial());

  Future<void> fetchOrders() async {
    emit(GetAllOrdersLoading());
    try {
      List<OrderModel> orders = await orderRepository.getAllOrders();
      emit(GetAllOrdersLoaded(orders));
    } catch (e) {
      emit(GetAllOrdersError('Failed to load orders: $e'));
    }
  }
}
