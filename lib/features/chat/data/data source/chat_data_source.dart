// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/core/error/exception.dart';
import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:ecom/features/chat/data/model/message_model.dart';

import '../../../auth/data/model/user_model.dart';

abstract class ChatDataSource {
  Future<void> storeMessagesInCollection(MessageModel message);
  Future<List<MessageModel>> getMessages(String otherUserId);
}

class ChatDataSourceImpl implements ChatDataSource {
  ChatDataSourceImpl({
    required this.fireCollections,
    required this.fireAuth,
  });

  final FireCollections fireCollections;
  final FireAuth fireAuth;

  List<MessageModel> messages = [];

  @override
  Future<void> storeMessagesInCollection(MessageModel message) async {
    messages.add(message);
    await fireCollections.storeMessagesInCollection(message);
  }

  @override
  Future<List<MessageModel>> getMessages(String otherUserId) async {
    final currentUserId = await fireAuth.getCurrentUserId();

    if (messages.isEmpty) {
      try {
        final messageDocs = await fireCollections.getMessages(
          currentUserId,
          otherUserId,
        );
        for (var msgDoc in messageDocs) {
          final msgJson = msgDoc.data();
          final senderSnap =
              await (msgJson['sender'] as DocumentReference).get();
          final senderJson = senderSnap.data() as Map<String, dynamic>;
          final sender = UserModel.fromMap(senderJson);

          final recieverSnap =
              await (msgJson['reciever'] as DocumentReference).get();
          final recieverJson = recieverSnap.data() as Map<String, dynamic>;
          final reciever = UserModel.fromMap(recieverJson);

          final msg = MessageModel.fromJson(
            json: msgJson,
            sender: sender,
            reciever: reciever,
          );
          messages.add(msg);
        }
        print(messages);
        return messages;
      } on ServerException {
        print('server Exception');
        rethrow;
      } catch (e) {
        print(e);
        throw ServerException();
      }
    } else {
      return messages;
    }
  }
}
