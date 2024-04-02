import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/data/model/user_model.dart';
import '../../domain/repository/chat_repository.dart';
import '../data%20source/chat_data_source.dart';
import '../model/message_model.dart';

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
  Future<Either<Failure, Stream<List<MessageModel>>>> fetchMessages(
      String otherUserId) async {
    try {
      final messages = dataSource.getMessages(otherUserId);
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
