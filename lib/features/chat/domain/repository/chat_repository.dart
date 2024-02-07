import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/message_model.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> sendMessage(MessageModel message);
}
