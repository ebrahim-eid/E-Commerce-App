class WishlistModel {
  final String id;
  final String name;
  final String image;
  final num price;

  WishlistModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['title'] ?? json['name'] ?? '',
      image: json['imageCover'] ?? json['image'] ?? '',
      price: json['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'price': price,
    };
  }
}
