import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {

  const UserEntity({
    required this.uid,
    required this.email,
    this.name,
    this.imageUrl,
    this.phNumber,
  });
  final String? uid;
  final String? name;
  final String? email;
  final String? imageUrl;
  final int? phNumber;

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        phNumber,
        imageUrl,
      ];
}
