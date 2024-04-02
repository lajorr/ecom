import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    super.name,
    super.phNumber,
    super.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'ph_number': phNumber,
      'image_url': imageUrl
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        phNumber: map['ph_number'],
        imageUrl: map['image_url']);
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    int? phNumber,
    String? imageUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phNumber: phNumber ?? this.phNumber,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory UserModel.fromFirebaseUser(User? user) {
    if (user != null) {
      return UserModel(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        phNumber: int.parse(user.phoneNumber ?? '0'),
        imageUrl: user.photoURL,
      );
    } else {
      return const UserModel(
        uid: null,
        name: null,
        email: null,
        phNumber: null,
        imageUrl: null,
      );
    }
  }
}
