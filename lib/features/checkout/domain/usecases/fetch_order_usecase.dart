import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/checkout/domain/model/order_model.dart';
import 'package:ecom/features/checkout/domain/repository/checkout_repository.dart';

class FetchOrderUsecase extends Usecase<OrderModel, NoParams> {
  final CheckoutRepository repository;

  FetchOrderUsecase({required this.repository});
  @override
  Future<Either<Failure, OrderModel>> call(NoParams params) async {
    return await repository.fetchOrder();
  }
}
