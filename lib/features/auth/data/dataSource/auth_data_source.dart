// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthDataSource {
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> signInWithGoogle();

  Future<User?> signUpWithEmailAndPassword(String email, String password);
  Future<User?> checkUser();

  Future<void> signOut();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FireAuth fireAuth;
  AuthDataSourceImpl({
    required this.fireAuth,
  });

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
    return user;
  }

  @override
  Future<User?> signInWithGoogle() async {
    final user = await fireAuth.signInWithGoogle();
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
}
