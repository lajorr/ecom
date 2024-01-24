// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final UserModel user;
  final List<CartModel> cartList;
  const OrderEntity({
    required this.user,
    required this.cartList,
  });

  @override
  List<Object?> get props => [
        user,
        cartList,
      ];
}
