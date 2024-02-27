import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../auth/data/model/user_model.dart';
import '../repository/profile_repository.dart';

class UploadProfilePictureUsecase extends Usecase<UserModel, Uint8List> {
  final ProfileRepository repository;

  UploadProfilePictureUsecase({required this.repository});

  @override
  Future<Either<Failure, UserModel>> call(Uint8List params) async {
    return await repository.uploadProfilePicture(params);
  }
}
