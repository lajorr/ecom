import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';

abstract class UserDataSource {
  Future<UserModel?> getCurrentUser();
  Future<UserModel?> updateUser({
    required String name,
    required int phNumber,
  });
}

class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl({required this.fireAuth});
  final FireAuth fireAuth;
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

    final user = currentUser.copyWith(
      name: name,
      phoneNumber: phNumber,
    );
    fireAuth.setUserData(user);
    return user;
  }
}
