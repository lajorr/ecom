import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/profile/domain/repository/profile_repository.dart';

class UploadProfilePictureUsecase extends Usecase<UserModel, Uint8List> {
  final ProfileRepository repository;

  UploadProfilePictureUsecase({required this.repository});

  @override
  Future<Either<Failure, UserModel>> call(Uint8List params) async {
    return await repository.uploadProfilePicture(params);
  }
}
