// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:ecom/features/chat/data/model/message_model.dart';

import '../../../../core/error/exception.dart';
import '../../../auth/data/model/user_model.dart';

abstract class ChatDataSource {
  Future<void> storeMessagesInCollection(MessageModel message);
  Stream<List<MessageModel>> getMessages(String otherUserId);
  Future<List<UserModel>> getChatRoomData();
}

class ChatDataSourceImpl implements ChatDataSource {
  ChatDataSourceImpl({
    required this.fireCollections,
    required this.fireAuth,
  });

  final FireCollections fireCollections;
  final FireAuth fireAuth;

  @override
  Future<void> storeMessagesInCollection(MessageModel message) async {
    await fireCollections.storeMessagesInCollection(message);
  }

  @override
  Stream<List<MessageModel>> getMessages(String otherUserId) async* {
    try {
      final messageDocs = fireCollections.getMessages(
        otherUserId,
      );

      await for (var msgDoc in messageDocs) {
        List<MessageModel> messageList = [];
        final msgDocs = msgDoc.docs;

        for (var msgDoc in msgDocs) {
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

          messageList.add(msg);
        }
        yield messageList;
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<UserModel>> getChatRoomData() async {
    List<UserModel> chatUserList = [];

    final userDocSnapList = await fireCollections.getUserChatRooms();

    for (var otherUser in userDocSnapList) {
      final otherUserData = otherUser.data() as Map<String, dynamic>;

      final otherUM = UserModel.fromMap(otherUserData);
      chatUserList.add(otherUM);
    }

    return chatUserList;
  }
}
