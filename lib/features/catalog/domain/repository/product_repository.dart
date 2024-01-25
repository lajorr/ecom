import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../shared/catalog/model/product_model.dart';
import '../../../../shared/likes/like_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProductData();

  Future<Either<Failure, bool>> likeUnlikeProd(String prodId);
  Future<Either<Failure, LikeModel>> fetchLikeDocument(String prodId);
}
