import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/cart_product_entity.dart';
import '../repository/checkout_repository.dart';

class AddToCartUsecase extends Usecase<void, CartProduct> {
  final CheckoutRepository repository;

  AddToCartUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(CartProduct params) {
    return repository.addToCart(params);
  }
}
