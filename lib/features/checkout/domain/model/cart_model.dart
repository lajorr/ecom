import '../entity/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.cId,
    required super.user,
    required super.products,
    required super.amount,
  });

  @override
  String toString() {
    return "cid:$cId, user:${user.name}, products:${products.length}, amount: $amount";
  }

  @override
  List<Object?> get props => [cId, user, products, amount];
}
