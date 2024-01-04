import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SetUserDataUsecase extends Usecase<void, User?> {
  final AuthRepository repository;

  SetUserDataUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(User? params) async {
    return await repository.setUserData(params);
  }
}
