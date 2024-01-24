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

class PayForCartEvent extends CheckoutEvent {}

class RemoveProdFromCartEvent extends CheckoutEvent {
  final ProductModel prod;

  const RemoveProdFromCartEvent({required this.prod});
}

class FetchOrderHistoryEvent extends CheckoutEvent{}
