import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/checkout_repository.dart';

import '../../../../core/usecase/usecase.dart';

class PlaceOrderUsecase extends Usecase<void, NoParams> {
  PlaceOrderUsecase({required this.repository});
  final CheckoutRepository repository;
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.placeOrder();
  }
}
