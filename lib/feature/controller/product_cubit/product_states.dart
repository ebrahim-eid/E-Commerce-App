abstract class ProductStates {}

class ProductInitialState extends ProductStates {}

/// All Product Model
class ProductLoadingState extends ProductStates {}

class ProductSuccessState extends ProductStates {}

class ProductErrorState extends ProductStates {
  final String error;

  ProductErrorState(this.error);

}

/// Product by id
class ProductByIdLoadingState extends ProductStates {}

class ProductByIdSuccessState extends ProductStates {}

class ProductByIdErrorState extends ProductStates {
  final String error;

  ProductByIdErrorState(this.error);

}

/// Products by subcategory
class ProductsBySubcategoryLoadingState extends ProductStates {}

class ProductsBySubcategorySuccessState extends ProductStates {}

class ProductsBySubcategoryErrorState extends ProductStates {
  final String error;

  ProductsBySubcategoryErrorState(this.error);

}
