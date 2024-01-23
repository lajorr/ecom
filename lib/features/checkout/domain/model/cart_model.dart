import 'package:ecom/features/checkout/domain/entity/enums/cart_status_enum.dart';

import '../entity/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    super.cId,
    required super.user,
    required super.products,
    required super.amount,
    super.cartStatus = CartStatus.cartCreated,
  });

  @override
  String toString() {
    return "cid:$cId, user:${user.name}, products:${products.length}, amount: $amount";
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'user': user.toMap(),
      'products': products.map(
        (prod) => prod.toMap(),
      ),
      'status': cartStatus.name,
    };
  }

  @override
  List<Object?> get props => [cId, user, products, amount];
}
