import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/favorites/data/datasource/favorites_datasource.dart';
import 'package:ecom/features/favorites/domain/repository/favorites_repository.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {

  FavoritesRepositoryImpl({required this.dataSource});
  final FavoritesDataSource dataSource;
  @override
  Future<Either<Failure, List<ProductModel>>> fetchFavProducts() async {
    try {
      final likeProds = await dataSource.fetchFavProducts();
      return Right(likeProds);
    } catch (e) {
      return const Left(
        ServerFailure(message: 'fetching products failed'),
      );
    }
  }
}
