import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entity/cart_product_entity.dart';
import '../../domain/model/cart_model.dart';
import '../../domain/repository/checkout_repository.dart';
import '../data%20source/checkout_data_source.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutDataSource dataSource;

  CheckoutRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, void>> addToCart(CartProduct product) async {
    print('ADD TO CART IMPLEMENTATION');

    try {
      final response = await dataSource.addProductToCart(product);
      return Right(response);
    } catch (e) {
      return Left(CartFailure());
    }
  }

  @override
  Future<Either<Failure, CartModel>> fetchCartProducts() async {
    print('FETCHING CART');

    try {
      final cartProd = await dataSource.fetchCartProducts();
      return Right(cartProd);
    } catch (e) {
      print("IMPL ERROR: $e");
      return Left(CartFailure());
    }
  }
}
