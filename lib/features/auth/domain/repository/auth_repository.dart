import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> loginWithEmail(String email, String password);
  Future<Either<Failure, User>> signUpWithEmail(String email, String password);

  Future<Either<Failure,User>> signInWithGoogle();
}
