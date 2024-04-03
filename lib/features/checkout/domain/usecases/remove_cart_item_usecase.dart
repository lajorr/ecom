import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/domain/repository/checkout_repository.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';

class RemoveCartItemUsecase extends Usecase<CartModel, ProductModel> {

  RemoveCartItemUsecase({required this.repository});
  final CheckoutRepository repository;
  @override
  Future<Either<Failure, CartModel>> call(ProductModel params) async{
    return await repository.removeCartItem(params);
  }
}
