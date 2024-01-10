import 'package:ecom/features/checkout/domain/entity/cart_product_entity.dart';

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
}
