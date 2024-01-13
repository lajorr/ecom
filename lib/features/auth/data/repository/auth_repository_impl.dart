import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repository/auth_repository.dart';
import '../dataSource/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, User>> loginWithEmail(
      String email, String password) async {
    try {
      final user = await dataSource.signInWithEmailAndPassword(email, password);
      return Right(user!);
    } on FirebaseAuthException {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmail(
      String email, String password) async {
    try {
      final user = await dataSource.signUpWithEmailAndPassword(email, password);
      return Right(user!);
    } on FirebaseAuthException {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final user = await dataSource.signInWithGoogle();
      return Right(user!);
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Either<Failure, User>> checkUser() async {
    try {
      final user = await dataSource.checkUser();

      if (user == null) {
        throw NoUserException();
      } else {
        return Right(user);
      }
    } on NoUserException {
      return Left(NoUserFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final response = await dataSource.signOut();
      return Right(response);
    } on FirebaseAuthException {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setUserData(User? user) async {
    try {
      final response = await dataSource.setUserData(user);
      return Right(response);
    } on ServerException {
      return Left(FirebaseFailure());
    }
  }
}
