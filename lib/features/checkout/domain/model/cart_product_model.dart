import 'package:ecom/shared/catalog/model/product_model.dart';

import '../entity/cart_product_entity.dart';

class CartProductModel extends CartProduct {
  const CartProductModel({
    required super.product,
    required super.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  factory CartProductModel.fromJson({
    required Map<String, dynamic> map,
    required ProductModel product,
  }) {
    return CartProductModel(
        product: product, quantity: (map['quantity'] as int));
  }
}
