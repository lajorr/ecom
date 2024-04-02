import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/chat/data/model/message_model.dart';
import 'package:ecom/features/chat/domain/repository/chat_repository.dart';

class SendMessageUsecase extends Usecase<void, MessageModel> {
  SendMessageUsecase({required this.repository});
  final ChatRepository repository;

  @override
  Future<Either<Failure, void>> call(MessageModel params) async {
    return await repository.sendMessage(params);
  }
}
