import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/order_model.dart';
import '../repository/checkout_repository.dart';

class FetchOrderUsecase extends Usecase<OrderModel, NoParams> {
  final CheckoutRepository repository;

  FetchOrderUsecase({required this.repository});
  @override
  Future<Either<Failure, OrderModel>> call(NoParams params) async {
    return await repository.fetchOrder();
  }
}
