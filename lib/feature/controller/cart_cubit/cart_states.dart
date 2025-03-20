abstract class CartStates {}

class CartInitialState extends CartStates {}
/// add to cart
class AddToCartLoadingState extends CartStates {}

class AddToCartSuccessState extends CartStates {}

class AddToCartErrorState extends CartStates {
  final String error;

  AddToCartErrorState(this.error);
}

/// remove from cart
class RemoveSpecificItemLoadingState extends CartStates {}

class RemoveSpecificItemSuccessState extends CartStates {}

class RemoveSpecificItemErrorState extends CartStates {
  final String error;

  RemoveSpecificItemErrorState(this.error);
}

/// delete user cart
class DeleteUserCartLoadingState extends CartStates {}

class DeleteUserCartSuccessState extends CartStates {}

class DeleteUserCartErrorState extends CartStates {
  final String error;

  DeleteUserCartErrorState(this.error);
}