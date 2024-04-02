import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/auth/domain/repository/auth_repository.dart';
import 'package:ecom/features/auth/domain/usecases/login_with_email_usecase.dart';

class SignupWithEmailUsecase extends Usecase<UserModel?, Params> {
  SignupWithEmailUsecase({
    required this.repository,
  });

  final AuthRepository repository;
  @override
  Future<Either<Failure, UserModel?>> call(Params params) async {
    return await repository.signUpWithEmail(params.email, params.password);
  }
}
