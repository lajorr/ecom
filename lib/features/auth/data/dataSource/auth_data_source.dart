import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

abstract interface class AuthDataSource {
  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<User?> signUpWithEmailAndPassword(String email, String password);
  Future<User?> checkUser();

  Future<void> signOut();
}

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl({
    required this.fireAuth,
    required this.fireCollections,
  });
  final FireAuth fireAuth;
  final FireCollections fireCollections;

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final user = await fireAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    final user =
        await fireAuth.signUpWithEmail(email: email, password: password);

    setUserData(user);
    return user;
  }

  @override
  Future<User?> checkUser() async {
    final user = fireAuth.currentUser;
    return user;
  }

  @override
  Future<void> signOut() async {
    fireAuth.signOut();
  }

  Future<void> setUserData(User? user) async {
    final myUser = UserModel.fromFirebaseUser(user);

    return await fireCollections.setUserData(user: myUser);
  }
}
