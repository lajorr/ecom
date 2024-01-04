import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckUserUsercase extends Usecase<User, NoParams> {
  final AuthRepository repository;

  CheckUserUsercase({required this.repository});
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.checkUser();
  }
}
