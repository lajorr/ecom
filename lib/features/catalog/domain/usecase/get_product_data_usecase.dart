import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/catalog/domain/repository/product_repository.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';

class GetProductDataUsecase extends Usecase<List<ProductModel>, NoParams> {

  GetProductDataUsecase({required this.repository});
  final ProductRepository repository;
  @override
  Future<Either<Failure, List<ProductModel>>> call(NoParams params) async {
    return await repository.getProductData();
  }
}
