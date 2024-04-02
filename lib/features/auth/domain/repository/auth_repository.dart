import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> loginWithEmail(String email, String password);
  Future<Either<Failure, UserModel?>> signUpWithEmail(
      String email, String password,);

  Future<Either<Failure, UserModel>> checkUser();

  Future<Either<Failure, void>> signOut();
}
