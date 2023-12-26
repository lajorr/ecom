import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/profile/domain/repository/profile_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchUserDataUsecase extends Usecase<User, NoParams> {
  final ProfileRepository repository;

  FetchUserDataUsecase({required this.repository});
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.fetchUserData();
  }
}
