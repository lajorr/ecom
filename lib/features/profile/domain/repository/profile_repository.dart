import 'package:dartz/dartz.dart';
import '../../../auth/data/model/user_model.dart';

import '../../../../core/error/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserModel>> fetchUserData();
  Future<Either<Failure, UserModel>> updateUserData(String name, int phNumber);
}
