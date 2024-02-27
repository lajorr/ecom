import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/message_model.dart';
import '../repository/chat_repository.dart';

class SendMessageUsecase extends Usecase<void, MessageModel> {
  SendMessageUsecase({required this.repository});
  final ChatRepository repository;

  @override
  Future<Either<Failure, void>> call(MessageModel params) async {
    return await repository.sendMessage(params);
  }
}
