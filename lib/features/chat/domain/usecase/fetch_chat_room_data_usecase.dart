import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../auth/data/model/user_model.dart';
import '../repository/chat_repository.dart';

class FetchChatRoomDataUsecase extends Usecase<List<UserModel>, NoParams> {
  FetchChatRoomDataUsecase({required this.repository});
  final ChatRepository repository;

  @override
  Future<Either<Failure, List<UserModel>>> call(NoParams params) async {
    return await repository.fetchChatRoomData();
  }
}
