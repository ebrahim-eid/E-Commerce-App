
class BrandModel {
  final String id;
  final String name;
  final String slug;
  final String image;

  BrandModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
      'image': image,
    };
  }
}
