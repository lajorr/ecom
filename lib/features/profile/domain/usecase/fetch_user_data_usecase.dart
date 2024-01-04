import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/profile/domain/repository/profile_repository.dart';

class FetchUserDataUsecase extends Usecase<UserModel, NoParams> {
  final ProfileRepository repository;

  FetchUserDataUsecase({required this.repository});
  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.fetchUserData();
  }
}
