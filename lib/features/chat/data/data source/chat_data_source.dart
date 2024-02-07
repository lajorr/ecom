import 'package:ecom/features/chat/data/model/message_model.dart';

abstract class ChatDataSource {
  Future<void> storeMessagesInCollection(MessageModel message);
}

class ChatDataSourceImpl implements ChatDataSource {
  @override
  Future<void> storeMessagesInCollection(MessageModel message) {
    // TODO: implement storeMessagesInCollection
    throw UnimplementedError();
  }
}
