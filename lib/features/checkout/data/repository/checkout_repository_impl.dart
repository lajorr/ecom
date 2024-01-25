import 'package:dartz/dartz.dart';
import '../../domain/model/order_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../shared/catalog/model/product_model.dart';
import '../../domain/model/cart_model.dart';
import '../../domain/model/cart_product_model.dart';
import '../../domain/repository/checkout_repository.dart';
import '../data%20source/checkout_data_source.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutDataSource dataSource;

  CheckoutRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, CartModel>> addToCart(CartProductModel product) async {
    try {
      final response = await dataSource.addProductToCart(product);

      return Right(response);
    } catch (e) {
      return Left(CartFailure());
    }
  }

  @override
  Future<Either<Failure, CartModel>> fetchCartProducts() async {
    try {
      final cartProd = await dataSource.fetchCartProducts();

      return Right(cartProd);
    } catch (e) {
      return Left(CartFailure());
    }
  }

  @override
  Future<Either<Failure, CartModel>> removeCartItem(ProductModel prod) async {
    try {
      final res = await dataSource.removeCartItem(prod);
      return Right(res);
    } catch (e) {
      return Left(CartFailure());
    }
  }

  @override
  Future<Either<Failure, void>> placeOrder() async {
    try {
      final res = await dataSource.placeOrder();
      return Right(res);
    } catch (e) {
      print(e.toString());
      return Left(DocumentFailure());
    }
  }

  @override
  Future<Either<Failure, OrderModel>> fetchOrder() async {
    try {
      final order = await dataSource.fetchAllOrders();
      
      return Right(order);
    } catch (e) {
      
      return Left(DocumentFailure());
    }
  }
}
