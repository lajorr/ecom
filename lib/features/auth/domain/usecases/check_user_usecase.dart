import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/user_model.dart';
import '../repository/auth_repository.dart';

class CheckUserUsercase extends Usecase<UserModel, NoParams> {
  final AuthRepository repository;

  CheckUserUsercase({required this.repository});
  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.checkUser();
  }
}
