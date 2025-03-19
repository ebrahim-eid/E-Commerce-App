
class WishlistModel {
  final String id;
  final String name;
  final String image;

  WishlistModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
    };
  }
}
