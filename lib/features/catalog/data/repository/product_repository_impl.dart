// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/exception.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/catalog/data/data_source/like_collection_data_source.dart';
import 'package:ecom/features/catalog/data/data_source/product_data_source.dart';
import 'package:ecom/features/catalog/domain/repository/product_repository.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';

import '../../../../shared/likes/like_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource productDataSource;
  final LikeCollectionDataSource likesDataSource;

  ProductRepositoryImpl({
    required this.productDataSource,
    required this.likesDataSource,
  });
  @override
  Future<Either<Failure, List<ProductModel>>> getProductData() async {
    try {
      final productList = await productDataSource.getProductList();
      return Right(productList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> createLikeDocument(String prodId) async {
    try {
      final response = await likesDataSource.createLikeDocument(prodId);
      return Right(response);
    } on DocumentException {
      return Left(DocumentFailure());
    }
  }

  @override
  Future<Either<Failure, LikeModel>> fetchLikeDocument(String prodId) async {
    try {
      final likeDoc = await likesDataSource.fetchLikeDocument(prodId);

      if (likeDoc == null) {
        throw DocumentException();
      } else {
        return Right(likeDoc);
      }
    } on DocumentException {
      return Left(DocumentFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> likeUnlikeProd(String prodId) async {
    
    final likeStatus = await likesDataSource.likeUnlikeProd(prodId);
    if (likeStatus == null) {
      return Left(DocumentFailure());
    } else {
      return Right(likeStatus);
    }
  }
}
