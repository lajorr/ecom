import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/profile/data/data%20source/user_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final UserDataSource dataSource;

  ProfileRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, User>> fetchUserData() async {
    final user = await dataSource.getCurrentUser();
    if (user == null) {
      return Left(NoUserFailure());
    } else {
      return Right(user);
    }
  }
}
