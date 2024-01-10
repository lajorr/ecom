// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../model/cart_product_model.dart';

class CartEntity extends Equatable {
  const CartEntity({
    required this.cId,
    required this.userId,
    required this.products,
    required this.amount,
  });

  final String cId;
  final String userId;
  final List<CartProductModel> products;

  final double amount;

  @override
  List<Object?> get props => [
        cId,
        userId,
        products,
      ];

  
}
