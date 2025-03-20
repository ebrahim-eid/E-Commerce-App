class AllProductModel {
  final int results;
  final List<DataModel> data;

  AllProductModel({required this.results, required this.data});

  factory AllProductModel.fromJson(Map<String, dynamic> json) {
    return AllProductModel(
      results: json['results'],
      data: (json['data'] as List).map((e) => DataModel.fromJson(e)).toList(),
    );
  }
}

class DataModel {
  final int sold;
  final List images;
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

  DataModel({
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

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      sold: json["sold"],
      images: List<String>.from(json["images"]),
      subcategory:
          (json['subcategory'] as List)
              .map((e) => SubcategoryModel.fromJson(e))
              .toList(),
      ratingsQuantity: json["ratingsQuantity"],
      sId: json["_id"],
      title: json["title"],
      slug: json["slug"],
      description: json["description"],
      quantity: json["quantity"],
      price: json["price"],
      imageCover: json["imageCover"],
      category: CategoryAndBrandModel.fromJson(json["category"]),
      brand: CategoryAndBrandModel.fromJson(json["brand"]),
      ratingsAverage:
          (json["ratingsAverage"] is int)
              ? (json["ratingsAverage"] as int).toDouble()
              : json["ratingsAverage"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      id: json["id"],
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
