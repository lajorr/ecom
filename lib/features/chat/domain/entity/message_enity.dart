// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  const MessageEntity({
    // required this.sender,
    // required this.reciever,
    required this.message,
    required this.createdAt,
    required this.senderId,
    required this.recieverId,
  });
  // final UserModel sender;
  // final UserModel reciever;
  final String message;
  final DateTime createdAt;

  final String senderId;
  final String recieverId;

  @override
  List<Object?> get props => [
        message,
        createdAt,
        recieverId,
        senderId,
      ];
}
