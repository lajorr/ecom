import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class SignOutUsecase extends Usecase<void, NoParams> {
  final AuthRepository repository;

  SignOutUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}
