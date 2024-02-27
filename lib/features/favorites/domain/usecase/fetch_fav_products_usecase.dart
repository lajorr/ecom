import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/catalog/model/product_model.dart';
import '../repository/favorites_repository.dart';

class FetchFavProductsUsecase extends Usecase<List<ProductModel>, NoParams> {
  final FavoritesRepository repository;

  FetchFavProductsUsecase({required this.repository});
  @override
  Future<Either<Failure, List<ProductModel>>> call(NoParams params) async {
    return await repository.fetchFavProducts();
  }
}
