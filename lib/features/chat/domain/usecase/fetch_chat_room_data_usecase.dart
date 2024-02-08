import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/chat/domain/repository/chat_repository.dart';

class FetchChatRoomDataUsecase extends Usecase<List<UserModel>, NoParams> {
  FetchChatRoomDataUsecase({required this.repository});
  final ChatRepository repository;

  @override
  Future<Either<Failure, List<UserModel>>> call(NoParams params) async {
    return await repository.fetchChatRoomData();
  }
}
