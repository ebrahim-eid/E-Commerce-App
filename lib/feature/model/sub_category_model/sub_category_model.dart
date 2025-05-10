class SubCategoryModel {
  final String id;
  final String name;
  final String category;
  final String image;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
    );
  }

  static List<SubCategoryModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SubCategoryModel.fromJson(json)).toList();
  }
}
