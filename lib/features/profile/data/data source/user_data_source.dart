// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:ecom/core/firebaseFunctions/firebase_storage.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';

abstract class UserDataSource {
  Future<UserModel?> getCurrentUser();
  Future<UserModel?> updateUser({
    required String name,
    required int phNumber,
  });

  Future<UserModel> storeUserProfilePicture(Uint8List image);
}

class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl({
    required this.fireAuth,
    required this.fireStorage,
    required this.fireCollections,
  });
  final FireAuth fireAuth;
  final FireStorage fireStorage;
  final FireCollections fireCollections;
  @override
  Future<UserModel?> getCurrentUser() async {
    final user = fireAuth.getCurrentUserModel();

    return user;
  }

  @override
  Future<UserModel?> updateUser({
    required String name,
    required int phNumber,
  }) async {
    final currentUser = await fireAuth.getCurrentUserModel();

    final user = currentUser!.copyWith(
      name: name,
      phNumber: phNumber,
    );
    await fireCollections.setUserData(user: user);
    return user;
  }

  @override
  Future<UserModel> storeUserProfilePicture(Uint8List image) async {
    final currentUser = await fireAuth.getCurrentUserModel();
    final downloadUrl =
        await fireStorage.uploadImageToStorage('profile', image);

    await fireCollections.setUserData(
      user: currentUser!,
      imageUrl: downloadUrl,
    );
    final updatedUser = currentUser.copyWith(imageUrl: downloadUrl);

    return updatedUser;
  }
}
