import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../auth/data/model/user_model.dart';
import '../repository/profile_repository.dart';

class FetchUserDataUsecase extends Usecase<UserModel, NoParams> {
  final ProfileRepository repository;

  FetchUserDataUsecase({required this.repository});
  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.fetchUserData();
  }
}
