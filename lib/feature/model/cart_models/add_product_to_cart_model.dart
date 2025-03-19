class CartModel {
  final String status;
  final String message;
  final int numOfCartItems;
  final String cartId;
  final CartData data;

  CartModel({
    required this.status,
    required this.message,
    required this.numOfCartItems,
    required this.cartId,
    required this.data,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      status: json['status'],
      message: json['message'],
      numOfCartItems: json['numOfCartItems'],
      cartId: json['cartId'],
      data: CartData.fromJson(json['data']),
    );
  }
}

class CartData {
  final String id;
  final String cartOwner;
  final List<CartProduct> products;
  final String createdAt;
  final String updatedAt;
  final int totalCartPrice;

  CartData({
    required this.id,
    required this.cartOwner,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
    required this.totalCartPrice,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['_id'],
      cartOwner: json['cartOwner'],
      products: (json['products'] as List)
          .map((e) => CartProduct.fromJson(e))
          .toList(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      totalCartPrice: json['totalCartPrice'],
    );
  }
}

class CartProduct {
  final int count;
  final String id;
  final String productId;
  final int price;

  CartProduct({
    required this.count,
    required this.id,
    required this.productId,
    required this.price,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      count: json['count'],
      id: json['_id'],
      productId: json['product'],
      price: json['price'],
    );
  }
}