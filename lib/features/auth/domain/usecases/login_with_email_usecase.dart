import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/user_model.dart';
import '../repository/auth_repository.dart';

class LoginWithEmailUsecase implements Usecase<UserModel, Params> {
  LoginWithEmailUsecase({required this.repository});
  final AuthRepository repository;

  @override
  Future<Either<Failure, UserModel>> call(Params params) async{
    return await repository.loginWithEmail(params.email, params.password);
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
