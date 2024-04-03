import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/checkout/domain/entity/cart_entity.dart';
import 'package:ecom/features/checkout/domain/entity/enums/cart_status_enum.dart';
import 'package:ecom/features/checkout/domain/model/cart_product_model.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.user, required super.products, required super.amount, super.cId,
    super.cartStatus = CartStatus.cartCreated,
    super.lat,
    super.lng,
    super.address,
  });

  @override
  String toString() {
    return 'cid:$cId, user:${user.name}, products:${products.length}, amount: $amount , status: ${cartStatus.name}, lat:$lat , lng:$lng , address:$address';
  }

  Map<String, dynamic> toMap({required DocumentReference userRef}) {
    return {
      'amount': amount,
      'user': userRef,
      'status': cartStatus.name,
      'lat': lat,
      'lng': lng,
      'address': address,
    };
  }

  CartModel copyWith({
    UserModel? user,
    List<CartProductModel>? products,
    double? amount,
    CartStatus? cartStatus,
    double? lat,
    double? lng,
    String? address,
  }) {
    return CartModel(
      user: user ?? this.user,
      products: products ?? this.products,
      amount: amount ?? this.amount,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      cartStatus: cartStatus ?? this.cartStatus,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
        cId,
        user,
        products,
        amount,
        lat,
        lng,
        address,
      ];
}
