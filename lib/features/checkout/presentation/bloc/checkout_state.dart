part of 'checkout_bloc.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();
}

final class CheckoutInitial extends CheckoutState {
  @override
  List<Object> get props => [];
}

final class CheckoutLoading extends CheckoutState {
  @override
  List<Object> get props => [];
}

final class CheckoutLoaded extends CheckoutState {
  final List<CartProduct> cartProductList;

  const CheckoutLoaded({required this.cartProductList});
  @override
  List<Object> get props => [];
}

final class CheckoutFailed extends CheckoutState {
  @override
  List<Object> get props => [];
}

final class CheckoutAddFailed extends CheckoutState {
  @override
  List<Object> get props => [];
}

final class CheckoutAddSuccess extends CheckoutState {
  @override
  List<Object> get props => [];
}
