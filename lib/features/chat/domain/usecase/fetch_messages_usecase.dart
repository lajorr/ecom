import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/message_model.dart';
import '../repository/chat_repository.dart';

class FetchMessagesUsecase extends Usecase<Stream<List<MessageModel>>, String> {
  final ChatRepository repository;

  FetchMessagesUsecase({required this.repository});

  @override
  Future<Either<Failure, Stream<List<MessageModel>>>> call(
      String params) async {
    return await repository.fetchMessages(params);
  }
}
