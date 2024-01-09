import 'package:ecom/features/checkout/domain/entity/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.cId,
    required super.user,
    required super.products,
    required super.amount,
  });
}
