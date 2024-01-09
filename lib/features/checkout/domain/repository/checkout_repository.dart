import 'package:dartz/dartz.dart';
import 'package:ecom/features/checkout/domain/entity/cart_product_entity.dart';

import '../../../../core/error/failures.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, void>> addToCart(CartProduct product);
  Future<Either<Failure, List<CartProduct>>> fetchCartProducts();
}
