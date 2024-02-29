import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/core/extensions/string_to_enum.dart';

import '../../domain/entity/message_enity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.message,
    required super.createdAt,
    required super.senderId,
    required super.recieverId,
    required super.messageType,
    super.photo,
    super.video,
    super.fileUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'reciever_id': recieverId,
      'created_at': createdAt,
      'message': message,
      'message_type': messageType.name,
      'file_url': fileUrl
    };
  }

  factory MessageModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    final date = (json['created_at'] as Timestamp).toDate().toString();
    return MessageModel(
      message: json['message'] as String,
      createdAt: DateTime.parse(date),
      recieverId: json['reciever_id'] as String,
      senderId: json['sender_id'] as String,
      messageType: (json['message_type'] as String).toMessageType(),
      fileUrl: json['file_url'] as String?,
    );
  }
}
