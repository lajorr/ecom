// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/checkout/domain/entity/cart_product_entity.dart';
import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  const CartEntity({
    required this.cId,
    required this.user,
    required this.products,
    required this.amount,
  });

  final String cId;
  final UserModel user;
  final List<CartProduct> products;

  final double amount;

  @override
  List<Object?> get props => [
        cId,
        user,
        products,
      ];
}
