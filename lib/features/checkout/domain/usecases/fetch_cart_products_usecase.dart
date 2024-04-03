import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/domain/repository/checkout_repository.dart';

class FetchCartProductsUsecase extends Usecase<CartModel, NoParams> {

  FetchCartProductsUsecase({required this.repository});
  final CheckoutRepository repository;
  @override
  Future<Either<Failure, CartModel>> call(NoParams params) async {
    return await repository.fetchCartProducts();
  }
}
