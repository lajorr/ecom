import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/catalog/domain/repository/product_repository.dart';

import '../../../../shared/likes/like_model.dart';

class FetchLikeDocUsecase extends Usecase<LikeModel, String> {
  final ProductRepository repository;

  FetchLikeDocUsecase({required this.repository});
  @override
  Future<Either<Failure, LikeModel>> call(String params) {
    return repository.fetchLikeDocument(params);
  }
}
