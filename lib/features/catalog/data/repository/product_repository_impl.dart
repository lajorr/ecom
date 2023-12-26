import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/exception.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/catalog/data/data_source/product_data_source.dart';
import 'package:ecom/features/catalog/domain/repository/product_repository.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource dataSource;

  ProductRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, List<ProductModel>>> getProductData() async {
    try {
      final productList = await dataSource.getProductList();
      return Right(productList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
