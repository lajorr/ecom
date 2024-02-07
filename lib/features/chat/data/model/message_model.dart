import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/chat/domain/entity/message_enity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.sender,
    required super.reciever,
    required super.message,
    required super.createdAt,
  });

  Map<String, dynamic> toMap({
    required DocumentReference senderRef,
    required DocumentReference recieverRef,
  }) {
    return {
      'sender': senderRef,
      'reciever': recieverRef,
      'created_at': createdAt,
      'message': message,
    };
  }

  factory MessageModel.fromJson({
    required Map<String, dynamic> json,
    required UserModel sender,
    required UserModel reciever,
  }) {
    final date = (json['created_at'] as Timestamp).toDate().toString();
    return MessageModel(
      sender: sender,
      reciever: reciever,
      message: json['message'],
      createdAt: DateTime.parse(date),
    );
  }
}
