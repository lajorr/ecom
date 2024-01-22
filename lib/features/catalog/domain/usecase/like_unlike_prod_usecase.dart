import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/catalog/domain/repository/product_repository.dart';

import '../../../../core/usecase/usecase.dart';

class LikeUnlikeProdUsecase extends Usecase<bool, String> {
  final ProductRepository repository;

  LikeUnlikeProdUsecase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.likeUnlikeProd(params);
  }
}
