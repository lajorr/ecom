import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/domain/repository/checkout_repository.dart';

import '../../../../shared/catalog/model/product_model.dart';

class RemoveCartItemUsecase extends Usecase<CartModel, ProductModel> {
  final CheckoutRepository repository;

  RemoveCartItemUsecase({required this.repository});
  @override
  Future<Either<Failure, CartModel>> call(ProductModel params) {
    return repository.removeCartItem(params);
  }
}
