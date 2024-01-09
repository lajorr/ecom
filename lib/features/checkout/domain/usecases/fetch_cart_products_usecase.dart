import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/cart_model.dart';
import '../repository/checkout_repository.dart';

class FetchCartProductsUsecase extends Usecase<CartModel, NoParams> {
  final CheckoutRepository repository;

  FetchCartProductsUsecase({required this.repository});
  @override
  Future<Either<Failure, CartModel>> call(NoParams params) {
    return repository.fetchCartProducts();
  }
}
