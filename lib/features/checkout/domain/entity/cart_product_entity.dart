// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:equatable/equatable.dart';

class CartProduct extends Equatable {
  final ProductModel product;
  final int quantity;

  const CartProduct({required this.product, required this.quantity});

  @override
  List<Object?> get props => [
        product,
        quantity,
      ];


}
