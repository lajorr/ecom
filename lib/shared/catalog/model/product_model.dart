import '../../../core/extensions/string_to_enum.dart';
import '../../../features/auth/data/model/user_model.dart';
import '../enitity/product_entity.dart';

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
    super.owner,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, UserModel? owner) {
    return ProductModel(
      id: json["id"],
      prodTitle: json["prod_title"],
      prodDescription: json["prod_description"],
      category: (json["category"] as String).toCategory(),
      listSizeColor: json["size_color"] == null
          ? []
          : List<SizeColor>.from(
              json["size_color"]!.map((x) => SizeColor.fromJson(x))),
      prodImage: List<ProdImage>.from(
          json["prod_image"].map((x) => ProdImage.fromJson(x))),
      rating: json["rating"]?.toDouble(),
      price: json["price"]?.toDouble(),
      viewsNo: json["views_no"],
      owner: owner,
    );
  }

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
        "owner": owner?.toMap(),
      };
}
