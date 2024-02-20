import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/likes/like_model.dart';
import '../repository/product_repository.dart';

class FetchLikeDocUsecase extends Usecase<LikeModel, String> {
  final ProductRepository repository;

  FetchLikeDocUsecase({required this.repository});
  @override
  Future<Either<Failure, LikeModel>> call(String params) async {
    return await repository.fetchLikeDocument(params);
  }
}
