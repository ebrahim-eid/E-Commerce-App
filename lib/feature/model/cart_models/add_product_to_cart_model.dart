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
    final dataField = json['data'];
    CartData cartData;
    if (dataField is Map<String, dynamic>) {
      cartData = CartData.fromJson(dataField);
    } else {
      cartData = CartData.empty();
    }
    return CartModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      numOfCartItems: json['numOfCartItems'] ?? 0,
      cartId: json['cartId'] ?? '',
      data: cartData,
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

  factory CartData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CartData.empty();
    return CartData(
      id: json['_id'] ?? '',
      cartOwner: json['cartOwner'] ?? '',
      products: (json['products'] as List?)?.map((e) => CartProduct.fromJson(e)).toList() ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      totalCartPrice: json['totalCartPrice'] ?? 0,
    );
  }

  factory CartData.empty() => CartData(
    id: '',
    cartOwner: '',
    products: [],
    createdAt: '',
    updatedAt: '',
    totalCartPrice: 0,
  );
}

class CartProduct {
  final int count;
  final String id;
  final String productId;
  final int price;
  final ProductDetails product;

  CartProduct({
    required this.count,
    required this.id,
    required this.productId,
    required this.price,
    required this.product,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    final productField = json['product'];
    ProductDetails productDetails;
    String productId;
    if (productField is Map<String, dynamic>) {
      productDetails = ProductDetails.fromJson(productField);
      productId = productField['_id'] ?? '';
    } else {
      productDetails = ProductDetails(
        id: productField ?? '',
        title: '',
        imageCover: '',
        ratingsAverage: 0.0,
      );
      productId = productField ?? '';
    }
    return CartProduct(
      count: json['count'],
      id: json['_id'],
      productId: productId,
      price: json['price'],
      product: productDetails,
    );
  }
}

class ProductDetails {
  final String id;
  final String title;
  final String imageCover;
  final double ratingsAverage;

  ProductDetails({
    required this.id,
    required this.title,
    required this.imageCover,
    required this.ratingsAverage,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['_id'],
      title: json['title'],
      imageCover: json['imageCover'],
      ratingsAverage: (json['ratingsAverage'] is int)
          ? (json['ratingsAverage'] as int).toDouble()
          : json['ratingsAverage'],
    );
  }
}