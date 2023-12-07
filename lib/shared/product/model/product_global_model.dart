// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String id;
  String prodTitle;
  String prodDescription;
  String category;
  List<SizeColor>? sizeColor;
  List<ProdImage> prodImage;
  double rating;
  double price;
  String viewsNo;

  Product({
    required this.id,
    required this.prodTitle,
    required this.prodDescription,
    required this.category,
    this.sizeColor,
    required this.prodImage,
    required this.rating,
    required this.price,
    required this.viewsNo,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        prodTitle: json["prod_title"],
        prodDescription: json["prod_description"],
        category: json["category"],
        sizeColor: json["size_color"] == null
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
        "size_color": sizeColor == null
            ? []
            : List<dynamic>.from(sizeColor!.map((x) => x.toJson())),
        "prod_image": List<dynamic>.from(prodImage.map((x) => x.toJson())),
        "rating": rating,
        "price": price,
        "views_no": viewsNo,
      };
}

class ProdImage {
  String imageUrl;
  Color color;

  ProdImage({
    required this.imageUrl,
    required this.color,
  });

  factory ProdImage.fromJson(Map<String, dynamic> json) => ProdImage(
        imageUrl: json["image_url"],
        color: Color.fromJson(json["color"]),
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "color": color.toJson(),
      };
}

class Color {
  String colorName;
  String colorCode;

  Color({
    required this.colorName,
    required this.colorCode,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        colorName: json["color_name"],
        colorCode: json["color_code"],
      );

  Map<String, dynamic> toJson() => {
        "color_name": colorName,
        "color_code": colorCode,
      };
}

class SizeColor {
  Color color;
  String size;

  SizeColor({
    required this.color,
    required this.size,
  });

  factory SizeColor.fromJson(Map<String, dynamic> json) => SizeColor(
        color: Color.fromJson(json["color"]),
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "color": color.toJson(),
        "size": size,
      };
}
