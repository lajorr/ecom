import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/domain/repository/checkout_repository.dart';

class PlaceOrderUsecase extends Usecase<void, CartModel> {
  PlaceOrderUsecase({required this.repository});
  final CheckoutRepository repository;
  @override
  Future<Either<Failure, void>> call(CartModel params) async {
    return await repository.placeOrder(params);
  }
}
