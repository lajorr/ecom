// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'package:ecom/shared/catalog/enitity/product_entity.dart';

// List<Product> productFromJson(String str) =>
//     List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

// String productToJson(List<Product> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.prodTitle,
    required super.prodDescription,
    required super.category,
    super.listSizeColor,
    required super.prodImage,
    required super.rating,
    required super.price,
    required super.viewsNo,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        prodTitle: json["prod_title"],
        prodDescription: json["prod_description"],
        category: json["category"],
        listSizeColor: json["size_color"] == null
            ? []
            : List<SizeColor>.from(
                json["size_color"]!.map((x) => SizeColor.fromJson(x))),
        prodImage: List<ProdImage>.from(
            json["prod_image"].map((x) => ProdImage.fromJson(x))),
        rating: json["rating"]?.toDouble(),
        price: json["price"]?.toDouble(),
        viewsNo: json["views_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prod_title": prodTitle,
        "prod_description": prodDescription,
        "category": category,
        "size_color": listSizeColor == null
            ? []
            : List<dynamic>.from(listSizeColor!.map((x) => x.toJson())),
        "prod_image": List<dynamic>.from(prodImage.map((x) => x.toJson())),
        "rating": rating,
        "price": price,
        "views_no": viewsNo,
      };
}
