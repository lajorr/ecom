import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/product_repository.dart';

import '../../../../core/usecase/usecase.dart';

class LikeUnlikeProdUsecase extends Usecase<bool, String> {
  final ProductRepository repository;

  LikeUnlikeProdUsecase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(String params) {
    return repository.likeUnlikeProd(params);
  }
}
