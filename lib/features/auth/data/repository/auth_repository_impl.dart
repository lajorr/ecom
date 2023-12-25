import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../dataSource/auth_data_source.dart';
import '../../domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
