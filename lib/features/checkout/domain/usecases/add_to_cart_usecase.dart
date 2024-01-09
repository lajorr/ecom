import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/checkout/domain/entity/cart_product_entity.dart';
import 'package:ecom/features/checkout/domain/repository/checkout_repository.dart';

class AddToCartUsecase extends Usecase<void, CartProduct> {
  final CheckoutRepository repository;

  AddToCartUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(CartProduct params) {
    return repository.addToCart(params);
  }
}
