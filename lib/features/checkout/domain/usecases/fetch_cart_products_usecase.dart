import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/checkout/domain/entity/cart_product_entity.dart';
import 'package:ecom/features/checkout/domain/repository/checkout_repository.dart';

class FetchCartProductsUsecase extends Usecase<List<CartProduct>, NoParams> {
  final CheckoutRepository repository;

  FetchCartProductsUsecase({required this.repository});
  @override
  Future<Either<Failure, List<CartProduct>>> call(NoParams params) {
    return repository.fetchCartProducts();
  }
}
