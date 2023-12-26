import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> loginWithEmail(String email, String password);
  Future<Either<Failure, User>> signUpWithEmail(String email, String password);

  Future<Either<Failure,User>> signInWithGoogle();

  Future<Either<Failure,User>> checkUser();

  Future<Either<Failure,void>> signOut();
}
