import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/profile/domain/repository/profile_repository.dart';

class UpdateUserDataUsecase extends Usecase<UserModel, UserParams> {
  UpdateUserDataUsecase({required this.repository});
  final ProfileRepository repository;

  @override
  Future<Either<Failure, UserModel>> call(UserParams params) {
    return repository.updateUserData(
      params.username,
      params.phNumber,
    );
  }
}

class UserParams {
  UserParams({
    required this.username,
    required this.phNumber,
  });
  final String username;
  final int phNumber;
}
