import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/catalog/domain/repository/product_repository.dart';
import 'package:ecom/shared/likes/like_model.dart';

class FetchLikeDocUsecase extends Usecase<LikeModel, String> {

  FetchLikeDocUsecase({required this.repository});
  final ProductRepository repository;
  @override
  Future<Either<Failure, LikeModel>> call(String params) async {
    return await repository.fetchLikeDocument(params);
  }
}
