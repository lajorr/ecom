import 'package:dartz/dartz.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/cart_product_model.dart';
import '../repository/checkout_repository.dart';

class AddToCartUsecase extends Usecase<CartModel, CartProductModel> {
  final CheckoutRepository repository;

  AddToCartUsecase({required this.repository});

  @override
  Future<Either<Failure, CartModel>> call(CartProductModel params) async {
    return await repository.addToCart(params);
  }
}
