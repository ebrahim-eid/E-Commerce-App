class UserOrderModel {
  final String id;
  final double totalPrice;
  final String paymentMethod;
  final bool isPaid;
  final bool isDelivered;
  final ShippingAddress shippingAddress;
  final UserModel user;
  final List<CartItem> cartItems;
  final String createdAt;

  UserOrderModel({
    required this.id,
    required this.totalPrice,
    required this.paymentMethod,
    required this.isPaid,
    required this.isDelivered,
    required this.shippingAddress,
    required this.user,
    required this.cartItems,
    required this.createdAt,
  });

  factory UserOrderModel.fromJson(Map<String, dynamic> json) {
    return UserOrderModel(
      id: json['_id'] ?? '',
      totalPrice: (json['totalOrderPrice'] ?? 0).toDouble(),
      paymentMethod: json['paymentMethodType'] ?? 'Unknown',
      isPaid: json['isPaid'] ?? false,
      isDelivered: json['isDelivered'] ?? false,
      createdAt: json['createdAt'] ?? '',

      // Parsing Nested Objects
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress'] ?? {}),
      user: UserModel.fromJson(json['user'] ?? {}),

      // Parsing List of Cart Items
      cartItems: (json['cartItems'] as List<dynamic>?)
          ?.map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}
class ShippingAddress {
  final String details;
  final String phone;
  final String city;

  ShippingAddress({required this.details, required this.phone, required this.city});

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      details: json['details'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
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
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}

class CartItem {
  final int count;
  final Product product;
  final double price;

  CartItem({required this.count, required this.product, required this.price});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      count: json['count'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      product: Product.fromJson(json['product'] ?? {}),
    );
  }
}

class Product {
  final String id;
  final String title;
  final String imageCover;
  final double ratingsAverage;

  Product({
    required this.id,
    required this.title,
    required this.imageCover,
    required this.ratingsAverage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      imageCover: json['imageCover'] ?? '',
      ratingsAverage: (json['ratingsAverage'] ?? 0).toDouble(),
    );
  }
}
