import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repository/auth_repository.dart';
import '../dataSource/auth_data_source.dart';
import '../model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, UserModel>> loginWithEmail(
      String email, String password) async {
    try {
      final user = await dataSource.signInWithEmailAndPassword(email, password);
      final userM = UserModel.fromFirebaseUser(user);
      return Right(userM);
    } on FirebaseAuthException {
      return const Left(FirebaseFailure());
    } on ServerException {
      return const Left(
        ServerFailure(message: "Cannot connect to the server"),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel?>> signUpWithEmail(
      String email, String password) async {
    try {
      final user = await dataSource.signUpWithEmailAndPassword(email, password);
      final userM = UserModel.fromFirebaseUser(user);
      return Right(userM);
    } on FirebaseAuthException {
      return const Left(FirebaseFailure());
    } on ServerException {
      return const Left(
        ServerFailure(message: "Cannot connect to the server"),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel>> checkUser() async {
    try {
      final user = await dataSource.checkUser();

      if (user == null) {
        throw NoUserException();
      } else {
        return Right(user);
      }
    } on NoUserException {
      return const Left(NoUserFailure(message: "No Such User"));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final response = await dataSource.signOut();
      return Right(response);
    } on FirebaseAuthException {
      return const Left(FirebaseFailure());
    } on ServerException {
      return const Left(
        ServerFailure(message: "Cannot connect to the server"),
      );
    }
  }
}
