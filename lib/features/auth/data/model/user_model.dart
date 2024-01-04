import 'package:ecom/features/auth/domain/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    required super.phNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phNumber': phNumber,
    };
  }

  UserModel copyWith(
      {String? uid, String? email, String? name, int? phoneNumber}) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phNumber: phoneNumber ?? phNumber,
    );
  }

  factory UserModel.fromFirebaseUser(User? user) {
    if (user != null) {
      return UserModel(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        phNumber: int.parse(user.phoneNumber ?? '0'),
      );
    } else {
      return const UserModel(
        uid: null,
        name: null,
        email: null,
        phNumber: null,
      );
    }
  }
}
