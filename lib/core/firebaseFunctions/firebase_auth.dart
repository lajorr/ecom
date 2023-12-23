import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final userCreds = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCreds.user;
  }

  Future<User?> signInWithGoogle() async {
    throw UnimplementedError();
  }

  Future<User?> signUpWithEmail(
      {required String email, required String password}) async {
    final userCred = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCred.user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
