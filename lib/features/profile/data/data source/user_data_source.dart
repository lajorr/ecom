import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserDataSource {
  Future<User?> getCurrentUser();
}

class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl({required this.fireAuth});
  final FireAuth fireAuth;
  @override
  Future<User?> getCurrentUser() async {
    return fireAuth.currentUser;
  }
}
