import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/cart_product_model.dart';
import '../repository/checkout_repository.dart';

class AddToCartUsecase extends Usecase<void, CartProductModel> {
  final CheckoutRepository repository;

  AddToCartUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(CartProductModel params) {
    return repository.addToCart(params);
  }
}
