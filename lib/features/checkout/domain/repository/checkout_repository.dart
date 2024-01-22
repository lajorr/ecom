import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../shared/catalog/model/product_model.dart';
import '../model/cart_model.dart';
import '../model/cart_product_model.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, CartModel>> addToCart(CartProductModel product);
  Future<Either<Failure, CartModel>> fetchCartProducts();
  Future<Either<Failure, void>> clearCartItems();
  Future<Either<Failure, CartModel>> removeCartItem(ProductModel prod);
}
