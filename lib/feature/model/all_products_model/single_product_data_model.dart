class SingleProductDataModel {
  final int sold;
  final List<String> images;
  final List<SubcategoryModel> subcategory;
  final int ratingsQuantity;
  final String sId;
  final String title;
  final String slug;
  final String description;
  final int quantity;
  final int price;
  final String imageCover;
  final CategoryAndBrandModel category;
  final CategoryAndBrandModel brand;
  final double ratingsAverage;
  final String createdAt;
  final String updatedAt;
  final String id;

  SingleProductDataModel({
    required this.sold,
    required this.images,
    required this.subcategory,
    required this.ratingsQuantity,
    required this.sId,
    required this.title,
    required this.slug,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageCover,
    required this.category,
    required this.brand,
    required this.ratingsAverage,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory SingleProductDataModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return SingleProductDataModel(
      sold: data["sold"],
      images: List<String>.from(data["images"]),
      subcategory: (data['subcategory'] as List)
          .map((e) => SubcategoryModel.fromJson(e))
          .toList(),
      ratingsQuantity: data["ratingsQuantity"],
      sId: data["_id"],
      title: data["title"],
      slug: data["slug"],
      description: data["description"],
      quantity: data["quantity"],
      price: data["price"],
      imageCover: data["imageCover"],
      category: CategoryAndBrandModel.fromJson(data["category"]),
      brand: CategoryAndBrandModel.fromJson(data["brand"]),
      ratingsAverage: (data["ratingsAverage"] is int)
          ? (data["ratingsAverage"] as int).toDouble()
          : data["ratingsAverage"],
      createdAt: data["createdAt"],
      updatedAt: data["updatedAt"],
      id: data["id"],
    );
  }
}

class SubcategoryModel {
  final String sId;
  final String name;
  final String slug;
  final String category;

  SubcategoryModel({
    required this.sId,
    required this.name,
    required this.slug,
    required this.category,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      sId: json['_id'],
      name: json['name'],
      slug: json['slug'],
      category: json['category'],
    );
  }
}

class CategoryAndBrandModel {
  final String sId;
  final String name;
  final String slug;
  final String image;

  CategoryAndBrandModel({
    required this.sId,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory CategoryAndBrandModel.fromJson(Map<String, dynamic> json) {
    return CategoryAndBrandModel(
      sId: json['_id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }
}
