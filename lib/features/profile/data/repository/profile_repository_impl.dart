import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/profile/data/data%20source/user_data_source.dart';
import 'package:ecom/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {

  ProfileRepositoryImpl({required this.dataSource});
  final UserDataSource dataSource;
  @override
  Future<Either<Failure, UserModel>> fetchUserData() async {
    final user = await dataSource.getCurrentUser();
    if (user == null) {
      return const Left(NoUserFailure(message: 'No User Found'));
    } else {
      return Right(user);
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUserData(
      String name, int phNumber,) async {
    final user = await dataSource.updateUser(
      name: name,
      phNumber: phNumber,
    );
    if (user == null) {
      return const Left(UserUpdateFailure(message: 'Fail to update use info'));
    } else {
      return Right(user);
    }
  }

  @override
  Future<Either<Failure, UserModel>> uploadProfilePicture(
      Uint8List imageFile,) async {
    try {
      final res = await dataSource.storeUserProfilePicture(imageFile);
      return Right(res);
    } catch (e) {
      return const Left(FirebaseFailure());
    }
  }
}
