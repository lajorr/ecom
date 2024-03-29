import 'package:dartz/dartz.dart';
import '../../../../shared/catalog/model/product_model.dart';

import '../../../../core/error/failures.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<ProductModel>>> fetchFavProducts();
}
