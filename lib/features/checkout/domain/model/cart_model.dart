import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/checkout/domain/entity/enums/cart_status_enum.dart';
import 'package:ecom/features/checkout/domain/model/cart_product_model.dart';

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
