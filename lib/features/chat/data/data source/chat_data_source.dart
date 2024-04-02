// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/core/error/exception.dart';
import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/chat/data/model/message_model.dart';

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

      await for (final msgDoc in messageDocs) {
        final messageList = <MessageModel>[];
        final msgDocs = msgDoc.docs;

        for (final msgDoc in msgDocs) {
          final msgJson = msgDoc.data();
          

          final msg = MessageModel.fromJson(
            json: msgJson,
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
    final chatUserList = <UserModel>[];

    final userDocSnapList = await fireCollections.getUserChatRooms();

    for (final otherUser in userDocSnapList) {
      final otherUserData = otherUser.data()! as Map<String, dynamic>;

      final otherUM = UserModel.fromMap(otherUserData);
      chatUserList.add(otherUM);
    }

    return chatUserList;
  }
}
