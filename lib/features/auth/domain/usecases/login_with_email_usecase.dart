import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class LoginWithEmailUsecase implements Usecase<UserModel, Params> {
  LoginWithEmailUsecase({required this.repository});
  final AuthRepository repository;

  @override
  Future<Either<Failure, UserModel>> call(Params params) async{
    return await repository.loginWithEmail(params.email, params.password);
  }
}

class Params extends Equatable {

  const Params({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
