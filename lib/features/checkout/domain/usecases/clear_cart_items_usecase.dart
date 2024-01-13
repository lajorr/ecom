import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/checkout/domain/repository/checkout_repository.dart';

class ClearCartItemsUsecase extends Usecase<void, NoParams> {
  final CheckoutRepository repository;

  ClearCartItemsUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(NoParams params) async{
    return await repository.clearCartItems();
  }
}
