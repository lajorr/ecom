import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/cart_product_entity.dart';
import '../repository/checkout_repository.dart';

class FetchCartProductsUsecase extends Usecase<List<CartProduct>, NoParams> {
  final CheckoutRepository repository;

  FetchCartProductsUsecase({required this.repository});
  @override
  Future<Either<Failure, List<CartProduct>>> call(NoParams params) {
    return repository.fetchCartProducts();
  }
}
