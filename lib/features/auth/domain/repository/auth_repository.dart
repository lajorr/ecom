import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> loginWithEmail(String email, String password);
  Future<Either<Failure, UserModel?>> signUpWithEmail(
      String email, String password);

  Future<Either<Failure, UserModel>> checkUser();

  Future<Either<Failure, void>> signOut();
}
