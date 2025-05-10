abstract class CartStates {}

class CartInitialState extends CartStates {}

/// get cart data
class GetCartLoadingState extends CartStates {}

class GetCartSuccessState extends CartStates {}

class GetCartErrorState extends CartStates {
  final String error;
  GetCartErrorState(this.error);
}

/// add to cart
class AddToCartLoadingState extends CartStates {}

class AddToCartSuccessState extends CartStates {}

class AddToCartErrorState extends CartStates {
  final String error;
  AddToCartErrorState(this.error);
}

/// update cart item
class UpdateCartItemLoadingState extends CartStates {}

class UpdateCartItemSuccessState extends CartStates {}

class UpdateCartItemErrorState extends CartStates {
  final String error;
  UpdateCartItemErrorState(this.error);
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