import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:ecom/shared/likes/like_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProductData();

  Future<Either<Failure, bool>> likeUnlikeProd(String prodId);
  Future<Either<Failure, LikeModel>> fetchLikeDocument(String prodId);
}
