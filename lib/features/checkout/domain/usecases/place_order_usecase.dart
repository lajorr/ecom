import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/cart_model.dart';
import '../repository/checkout_repository.dart';

class PlaceOrderUsecase extends Usecase<void, CartModel> {
  PlaceOrderUsecase({required this.repository});
  final CheckoutRepository repository;
  @override
  Future<Either<Failure, void>> call(CartModel params) async {
    return await repository.placeOrder(params);
  }
}
