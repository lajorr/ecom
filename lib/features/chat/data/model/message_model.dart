import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/message_enity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.message,
    required super.createdAt,
    required super.senderId,
    required super.recieverId,
  });

  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'reciever_id': recieverId,
      'created_at': createdAt,
      'message': message,
    };
  }

  factory MessageModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    final date = (json['created_at'] as Timestamp).toDate().toString();
    return MessageModel(
      message: json['message'],
      createdAt: DateTime.parse(date),
      recieverId: json['reciever_id'],
      senderId: json['sender_id'],
    );
  }
}
