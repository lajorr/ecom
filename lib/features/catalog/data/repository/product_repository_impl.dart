import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/exception.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/catalog/data/data_source/like_collection_data_source.dart';
import 'package:ecom/features/catalog/data/data_source/product_data_source.dart';
import 'package:ecom/features/catalog/domain/repository/product_repository.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:ecom/shared/likes/like_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required this.productDataSource,
    required this.likesDataSource,
  });
  final ProductDataSource productDataSource;
  final LikeCollectionDataSource likesDataSource;
  @override
  Future<Either<Failure, List<ProductModel>>> getProductData() async {
    try {
      final productList = await productDataSource.getAllProductList();
      return Right(productList);
    } on ServerException {
      return const Left(ServerFailure(message: 'Unable to fetch Data'));
    }
  }

  @override
  Future<Either<Failure, LikeModel>> fetchLikeDocument(String prodId) async {
    try {
      final likeDoc = await likesDataSource.fetchLikeDocument(prodId);

      return Right(likeDoc);
    } on DocumentException {
      return const Left(DocumentFailure(message: 'Like Doc Not Fetched'));
    }
  }

  @override
  Future<Either<Failure, bool>> likeUnlikeProd(String prodId) async {
    final likeStatus = await likesDataSource.likeUnlikeProd(prodId);
    if (likeStatus == null) {
      return const Left(DocumentFailure(message: 'No Like Status'));
    } else {
      return Right(likeStatus);
    }
  }
}
