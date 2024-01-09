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
  final CartProduct cartProduct;
}

class FetchCartProductsEvent extends CheckoutEvent {}
