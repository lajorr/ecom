import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/domain/model/cart_product_model.dart';
import 'package:ecom/features/checkout/domain/model/order_model.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, CartModel>> addToCart(CartProductModel product);
  Future<Either<Failure, CartModel>> fetchCartProducts();

  Future<Either<Failure, CartModel>> removeCartItem(ProductModel prod);

  Future<Either<Failure, void>> placeOrder(CartModel cartM);
  Future<Either<Failure, OrderModel>> fetchOrder();


}
