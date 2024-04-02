// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/checkout/domain/entity/enums/cart_status_enum.dart';
import 'package:ecom/features/checkout/domain/model/cart_product_model.dart';
import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  const CartEntity({
    required this.user, required this.products, required this.amount, required this.cartStatus, this.cId,
    this.lat,
    this.lng,
    this.address,
  });

  final String? cId;
  final UserModel user;
  final List<CartProductModel> products;
  final double amount;
  final CartStatus cartStatus;

  final double? lat;
  final double? lng;

  final String? address;

  @override
  List<Object?> get props => [
        cId,
        user,
        products,
        amount,
        cartStatus,
      ];
}
