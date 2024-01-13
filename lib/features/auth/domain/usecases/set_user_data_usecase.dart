import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class SetUserDataUsecase extends Usecase<void, User?> {
  final AuthRepository repository;

  SetUserDataUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(User? params) async {
    return await repository.setUserData(params);
  }
}
