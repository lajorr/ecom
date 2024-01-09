import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/product_repository.dart';

import '../../../../core/usecase/usecase.dart';

class CreateLikeDocumentUsecase extends Usecase<void, String> {
  final ProductRepository repository;

  CreateLikeDocumentUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(String params) {
    return repository.createLikeDocument(params);
  }
}
