class OrderModel {
  final String id;
  final String paymentMethodType;
  final bool isPaid;
  final bool isDelivered;
  final double totalOrderPrice;
  final ShippingAddress shippingAddress;
  final UserModel user;
  final List<CartItem> cartItems;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.paymentMethodType,
    required this.isPaid,
    required this.isDelivered,
    required this.totalOrderPrice,
    required this.shippingAddress,
    required this.user,
    required this.cartItems,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      paymentMethodType: json['paymentMethodType'],
      isPaid: json['isPaid'],
      isDelivered: json['isDelivered'],
      totalOrderPrice: json['totalOrderPrice'].toDouble(),
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress']),
      user: UserModel.fromJson(json['user']),
      cartItems: (json['cartItems'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class ShippingAddress {
  final String phone;
  final String city;
  final String details;

  ShippingAddress({required this.phone, required this.city, required this.details});

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      phone: json['phone'],
      city: json['city'],
      details: json['details'],
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;

  UserModel({required this.id, required this.name, required this.email, required this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class CartItem {
  final int count;
  final double price;
  final ProductModel product;

  CartItem({required this.count, required this.price, required this.product});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      count: json['count'],
      price: json['price'].toDouble(),
      product: ProductModel.fromJson(json['product']),
    );
  }
}

class ProductModel {
  final String id;
  final String title;
  final String imageCover;
  final double ratingsAverage;

  ProductModel({required this.id, required this.title, required this.imageCover, required this.ratingsAverage});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      title: json['title'],
      imageCover: json['imageCover'],
      ratingsAverage: json['ratingsAverage'].toDouble(),
    );
  }
}
