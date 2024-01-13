import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/checkout_repository.dart';

class ClearCartItemsUsecase extends Usecase<void, NoParams> {
  final CheckoutRepository repository;

  ClearCartItemsUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(NoParams params) async{
    return await repository.clearCartItems();
  }
}
