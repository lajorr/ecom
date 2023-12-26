import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String prodTitle;
  final String prodDescription;
  final String category;
  final List<SizeColor>? listSizeColor;
  final List<ProdImage> prodImage;
  final double rating;
  final double price;
  final String viewsNo;

  const ProductEntity({
    required this.id,
    required this.prodTitle,
    required this.prodDescription,
    required this.category,
    this.listSizeColor,
    required this.prodImage,
    required this.rating,
    required this.price,
    required this.viewsNo,
  });

  @override
  List<Object?> get props => [
        id,
        prodTitle,
        prodDescription,
        category,
        listSizeColor,
        prodImage,
        rating,
        price,
        viewsNo,
      ];
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
