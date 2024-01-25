import '../entity/cart_entity.dart';
import '../entity/enums/cart_status_enum.dart';

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
    return "cid:$cId, user:${user.name}, products:${products.length}, amount: $amount , status: ${cartStatus.name}";
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'user': user.toMap(),
      'products': products.map(
        (prod) => prod.toMap(),
      ).toList(),
      'status': cartStatus.name,
    };
  }

  // factory CartModel.fromJson(Map<String,dynamic> map, UserModel user)
  // {
  //   final prods = map['products'] as List;
  //   final modelPrds = prods.map((prodMap) => CartProductModel.fromJson(map: prodMap,product: ),).toList();
  //   return CartModel(user: user, products: , amount: amount)
  // }

  @override
  List<Object?> get props => [cId, user, products, amount];
}
