import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';
import 'login_with_email_usecase.dart';

class SignupWithEmailUsecase extends Usecase<User?, Params> {
  SignupWithEmailUsecase({
    required this.repository,
  });

  final AuthRepository repository;
  @override
  Future<Either<Failure, User?>> call(params) async {
    return await repository.signUpWithEmail(params.email, params.password);
  }
}
