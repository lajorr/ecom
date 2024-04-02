import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/auth/domain/repository/auth_repository.dart';

class CheckUserUsercase extends Usecase<UserModel, NoParams> {

  CheckUserUsercase({required this.repository});
  final AuthRepository repository;
  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.checkUser();
  }
}
