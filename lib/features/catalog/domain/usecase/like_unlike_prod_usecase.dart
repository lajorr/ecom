import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/catalog/domain/repository/product_repository.dart';

class LikeUnlikeProdUsecase extends Usecase<bool, String> {

  LikeUnlikeProdUsecase({required this.repository});
  final ProductRepository repository;
  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.likeUnlikeProd(params);
  }
}
