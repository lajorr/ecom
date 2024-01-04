import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/profile/data/data%20source/user_data_source.dart';

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
