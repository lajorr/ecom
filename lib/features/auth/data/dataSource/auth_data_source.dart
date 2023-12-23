// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthDataSource {
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> loginWithhGoogle();

  // Future<User?> signUpWithEmailAndPassword();
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
  Future<User?> loginWithhGoogle() {
    // TODO: implement loginWithhGoogle
    throw UnimplementedError();
  }
}
