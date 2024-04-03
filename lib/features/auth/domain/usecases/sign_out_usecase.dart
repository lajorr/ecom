import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/domain/repository/auth_repository.dart';

class SignOutUsecase extends Usecase<void, NoParams> {

  SignOutUsecase({required this.repository});
  final AuthRepository repository;
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}
