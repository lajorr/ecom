import 'package:ecom/features/auth/domain/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    super.name,
    super.phNumber,
    super.imageUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'] as String?,
        email: map['email'] as String?,
        name: map['name'] as String?,
        phNumber: map['ph_number'] as int?,
        imageUrl: map['image_url'] as String?,);
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
        email: null,
      );
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'ph_number': phNumber,
      'image_url': imageUrl,
    };
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
}
