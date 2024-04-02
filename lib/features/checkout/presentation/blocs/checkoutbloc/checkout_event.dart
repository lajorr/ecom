part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CheckoutEvent {
  const AddToCartEvent({
    required this.cartProduct,
  });
  final CartProductModel cartProduct;
}

class FetchCartProductsEvent extends CheckoutEvent {}

class RemoveProdFromCartEvent extends CheckoutEvent {

  const RemoveProdFromCartEvent({required this.prod});
  final ProductModel prod;
}

class ClearLocalDataEvent extends CheckoutEvent {}
