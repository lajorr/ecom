import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/catalog/domain/repository/product_repository.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';

class FetchFavProductsUsecase extends Usecase<List<ProductModel>, NoParams> {
  final ProductRepository repository;

  FetchFavProductsUsecase({required this.repository});
  @override
  Future<Either<Failure, List<ProductModel>>> call(NoParams params) {
    throw UnimplementedError();
  }
}
