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
  const CheckoutLoaded({
    required this.cartModel,
  });

  final CartModel cartModel;

  @override
  List<Object> get props => [
        cartModel,
      ];
}

final class CheckoutFetchFailed extends CheckoutState {
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

final class CheckoutPaymentFailed extends CheckoutState {
  @override
  List<Object> get props => [];
}

final class CheckoutPaymentSuccess extends CheckoutState {
  @override
  List<Object> get props => [];
}

final class CheckoutRemoveItemFailed extends CheckoutState {
  @override
  List<Object> get props => [];
}




