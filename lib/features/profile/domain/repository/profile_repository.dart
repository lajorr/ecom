import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserModel>> fetchUserData();
  Future<Either<Failure, UserModel>> updateUserData(String name, int phNumber);
  Future<Either<Failure, UserModel>> uploadProfilePicture(Uint8List imageFile);
}
