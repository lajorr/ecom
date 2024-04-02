import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/chat/data/model/message_model.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> sendMessage(MessageModel message);
  Future<Either<Failure, Stream<List<MessageModel>>>> fetchMessages(
      String otherUserId,);
  Future<Either<Failure, List<UserModel>>> fetchChatRoomData();
}
