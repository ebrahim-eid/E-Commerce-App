part of 'user_order_cubit.dart';


abstract class UserOrderState {}

class UserOrderInitial extends UserOrderState {}

class UserOrderLoading extends UserOrderState {}

class UserOrderLoaded extends UserOrderState {
  final List<UserOrderModel> orders;
  UserOrderLoaded(this.orders);
}

class UserOrderError extends UserOrderState {
  final String message;
  UserOrderError(this.message);
}
