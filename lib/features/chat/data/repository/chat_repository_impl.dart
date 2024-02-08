import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/exception.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/chat/data/data%20source/chat_data_source.dart';
import 'package:ecom/features/chat/data/model/message_model.dart';
import 'package:ecom/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl({required this.dataSource});
  final ChatDataSource dataSource;
  @override
  Future<Either<Failure, void>> sendMessage(MessageModel message) async {
    try {
      final res = await dataSource.storeMessagesInCollection(message);
      return Right(res);
    } catch (e) {
      return const Left(ServerFailure(message: 'Message not sent'));
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> fetchMessages(
      String otherUserId) async {
    try {
      final messages = await dataSource.getMessages(otherUserId);
      return Right(messages);
    } on ServerException {
      return const Left(
        ServerFailure(message: "Unable to fetch messages"),
      );
    } catch (e) {
      return const Left(
        ServerFailure(message: 'Something Went Wrong'),
      );
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> fetchChatRoomData() async {
    try {
      final users = await dataSource.getChatRoomData();
      return Right(users);
    } catch (e) {
      return const Left(ServerFailure(message: 'Unable to fetch rooms'));
    }
  }
}
