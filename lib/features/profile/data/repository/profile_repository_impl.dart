import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/data/model/user_model.dart';
import '../data%20source/user_data_source.dart';

import '../../domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final UserDataSource dataSource;

  ProfileRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, UserModel>> fetchUserData() async {
    final user = await dataSource.getCurrentUser();
    if (user == null) {
      return Left(NoUserFailure());
    } else {
      return Right(user);
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUserData(
      String name, int phNumber) async {
    final user = await dataSource.updateUser(
      name: name,
      phNumber: phNumber,
    );
    if (user == null) {
      return Left(UserUpdateFailure());
    } else {
      return Right(user);
    }
  }
}
