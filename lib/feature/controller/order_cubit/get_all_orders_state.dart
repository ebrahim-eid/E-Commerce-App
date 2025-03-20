part of 'get_all_orders_cubit.dart';

abstract class GetAllOrdersState {
  const GetAllOrdersState();
}

class GetAllOrdersInitial extends GetAllOrdersState {}

class GetAllOrdersLoading extends GetAllOrdersState {}

class GetAllOrdersLoaded extends GetAllOrdersState {
  final List<OrderModel> orders;
  const GetAllOrdersLoaded(this.orders);
}

class GetAllOrdersError extends GetAllOrdersState {
  final String message;
  const GetAllOrdersError(this.message);
}
