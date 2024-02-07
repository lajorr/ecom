import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  const MessageEntity({
    required this.sender,
    required this.reciever,
    required this.message,
    required this.createdAt,
  });
  final UserModel sender;
  final UserModel reciever;
  final String message;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        sender,
        reciever,
        message,
        createdAt,
      ];
}
