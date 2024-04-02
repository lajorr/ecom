import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/product_repository.dart';

class LikeUnlikeProdUsecase extends Usecase<bool, String> {
  final ProductRepository repository;

  LikeUnlikeProdUsecase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.likeUnlikeProd(params);
  }
}
