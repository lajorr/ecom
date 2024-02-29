// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class MessageEntity extends Equatable {
  const MessageEntity({
    required this.message,
    required this.createdAt,
    required this.senderId,
    required this.recieverId,
    required this.messageType,
    this.photo,
    this.video,
    this.fileUrl,
  });

  final String message;
  final DateTime createdAt;

  final String senderId;
  final String recieverId;

  final MessageType messageType;
  final XFile? photo;
  final XFile? video;
  final String? fileUrl;

  @override
  List<Object?> get props => [
        message,
        createdAt,
        recieverId,
        senderId,
        messageType,
        photo,
        video,
      ];
}

enum MessageType {
  text,
  photo,
  video,
}
