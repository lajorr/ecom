import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../model/cart_model.dart';
import '../model/cart_product_model.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, void>> addToCart(CartProductModel product);
  Future<Either<Failure, CartModel>> fetchCartProducts();
}
