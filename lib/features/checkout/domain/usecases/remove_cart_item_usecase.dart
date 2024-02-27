import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/catalog/model/product_model.dart';
import '../model/cart_model.dart';
import '../repository/checkout_repository.dart';

class RemoveCartItemUsecase extends Usecase<CartModel, ProductModel> {
  final CheckoutRepository repository;

  RemoveCartItemUsecase({required this.repository});
  @override
  Future<Either<Failure, CartModel>> call(ProductModel params) async{
    return await repository.removeCartItem(params);
  }
}
