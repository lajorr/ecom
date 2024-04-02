import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/domain/model/cart_product_model.dart';
import 'package:ecom/features/checkout/domain/repository/checkout_repository.dart';

class AddToCartUsecase extends Usecase<CartModel, CartProductModel> {

  AddToCartUsecase({required this.repository});
  final CheckoutRepository repository;

  @override
  Future<Either<Failure, CartModel>> call(CartProductModel params) async {
    return await repository.addToCart(params);
  }
}
