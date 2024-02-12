import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../features/auth/data/model/user_model.dart';

class FireAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection('users');

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserModel> getCurrentUserModel() async {
    UserModel user;

    final userDocSnapshot = await userCollection.doc(currentUser!.uid).get();
    if (userDocSnapshot.exists) {
      final userJson = userDocSnapshot.data();
      user = UserModel.fromMap(userJson!);
    } else {
      user = UserModel(
        uid: currentUser!.uid,
        email: currentUser!.email,
      );
    }

    return user;
  }

  String getCurrentUserId() {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final userCreds = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCreds.user;
  }

  Future<User?> signInWithGoogle() async {
    debugPrint('googgle Sign in firebase auth');
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
