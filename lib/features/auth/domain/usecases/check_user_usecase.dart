import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class CheckUserUsercase extends Usecase<User, NoParams> {
  final AuthRepository repository;

  CheckUserUsercase({required this.repository});
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.checkUser();
  }
}
