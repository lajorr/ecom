import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/chat/data/model/message_model.dart';
import 'package:ecom/features/chat/domain/repository/chat_repository.dart';

class FetchMessagesUsecase extends Usecase<List<MessageModel>, String> {
  final ChatRepository repository;

  FetchMessagesUsecase({required this.repository});

  @override
  Future<Either<Failure, List<MessageModel>>> call(String params) async {
    return await repository.fetchMessages(params);
  }
}
