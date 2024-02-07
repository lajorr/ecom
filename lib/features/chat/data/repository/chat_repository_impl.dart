import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
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
      print(e);
      return const Left(ServerFailure(message: 'Message not sent'));
    }
  }
}
