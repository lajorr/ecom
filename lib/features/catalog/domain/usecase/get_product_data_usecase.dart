import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/catalog/model/product_model.dart';
import '../repository/product_repository.dart';

class GetProductDataUsecase extends Usecase<List<ProductModel>, NoParams> {
  final ProductRepository repository;

  GetProductDataUsecase({required this.repository});
  @override
  Future<Either<Failure, List<ProductModel>>> call(NoParams params) async {
    return repository.getProductData();
  }
}
