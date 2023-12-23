import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/auth/data/dataSource/auth_data_source.dart';
import 'package:ecom/features/auth/domain/repository/auth_repository.dart';
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

  // @override
  // Future<Either<Failure, User>> signUpWithEmail() async{
  //   try {
  //     final user = await dataSource.si
  //   } catch (e) {
      
  //   }
  // }
}
