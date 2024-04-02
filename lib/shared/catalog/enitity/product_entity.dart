import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/shared/catalog/enitity/enum/category_enum.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {

  const ProductEntity({
    required this.id, required this.prodTitle, required this.prodDescription, required this.category, required this.prodImage, required this.rating, required this.price, required this.viewsNo, this.owner,
    this.listSizeColor,
  });
  final String id;
  final String prodTitle;
  final String prodDescription;
  final Category category;
  final List<SizeColor>? listSizeColor;
  final List<ProdImage> prodImage;
  final double rating;
  final double price;
  final String viewsNo;
  final UserModel? owner;

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
        owner,
      ];
}

class ProdImage {

  ProdImage({
    required this.imageUrl,
    required this.color,
  });

  factory ProdImage.fromJson(Map<String, dynamic> json) => ProdImage(
        imageUrl: json['image_url'],
        color: Color.fromJson(json['color']),
      );
  String imageUrl;
  Color color;

  Map<String, dynamic> toJson() => {
        'image_url': imageUrl,
        'color': color.toJson(),
      };
}

class Color {

  Color({
    required this.colorName,
    required this.colorCode,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        colorName: json['color_name'],
        colorCode: json['color_code'],
      );
  String colorName;
  String colorCode;

  Map<String, dynamic> toJson() => {
        'color_name': colorName,
        'color_code': colorCode,
      };
}

class SizeColor {

  SizeColor({
    required this.color,
    required this.size,
  });

  factory SizeColor.fromJson(Map<String, dynamic> json) => SizeColor(
        color: Color.fromJson(json['color']),
        size: json['size'],
      );
  Color color;
  String size;

  Map<String, dynamic> toJson() => {
        'color': color.toJson(),
        'size': size,
      };
}
