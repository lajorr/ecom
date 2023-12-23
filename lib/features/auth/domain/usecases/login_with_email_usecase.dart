import 'package:dartz/dartz.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';

class LoginWithEmailUsecase implements Usecase<User, Params> {
  LoginWithEmailUsecase({required this.repository});
  final AuthRepository repository;

  @override
  Future<Either<Failure, User>> call(Params params) {
    return repository.loginWithEmail(params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({required this.email, required this.password});

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
