import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/cart_product_entity.dart';
import '../model/cart_model.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, void>> addToCart(CartProduct product);
  Future<Either<Failure, CartModel>> fetchCartProducts();
}
