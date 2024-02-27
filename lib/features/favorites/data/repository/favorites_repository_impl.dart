import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../datasource/favorites_datasource.dart';
import '../../domain/repository/favorites_repository.dart';
import '../../../../shared/catalog/model/product_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDataSource dataSource;

  FavoritesRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, List<ProductModel>>> fetchFavProducts() async {
    try {
      final likeProds = await dataSource.fetchFavProducts();
      return Right(likeProds);
    } catch (e) {
      return const Left(
        ServerFailure(message: "fetching products failed"),
      );
    }
  }
}
