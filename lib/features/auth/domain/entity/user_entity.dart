import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  // final String? imageUrl;
  final int? phNumber;

  const UserEntity({
    required this.uid,
    this.name,
    required this.email,
    this.phNumber,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        phNumber,
      ];
}
