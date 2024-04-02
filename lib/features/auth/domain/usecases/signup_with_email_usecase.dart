import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/user_model.dart';
import '../repository/auth_repository.dart';
import 'login_with_email_usecase.dart';

class SignupWithEmailUsecase extends Usecase<UserModel?, Params> {
  SignupWithEmailUsecase({
    required this.repository,
  });

  final AuthRepository repository;
  @override
  Future<Either<Failure, UserModel?>> call(params) async {
    return await repository.signUpWithEmail(params.email, params.password);
  }
}
