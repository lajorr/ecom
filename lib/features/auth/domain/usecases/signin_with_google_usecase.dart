import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninWithGoogleUsecase extends Usecase<User, NoParams> {
  SigninWithGoogleUsecase({required this.repository});
  final AuthRepository repository;
  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return repository.signInWithGoogle();
  }
}

