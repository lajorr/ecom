import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProductData();
}
