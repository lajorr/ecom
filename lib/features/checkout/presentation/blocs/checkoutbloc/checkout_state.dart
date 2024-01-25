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
  const CheckoutPaymentFailed({required this.message});
  final String message;
  @override
  List<Object> get props => [];
}

final class CheckoutPaymentSuccess extends CheckoutState {
  const CheckoutPaymentSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [];
}

final class CheckoutRemoveItemFailed extends CheckoutState {
  @override
  List<Object> get props => [];
}

final class CheckoutRemoveItemSuccess extends CheckoutState {
  const CheckoutRemoveItemSuccess({required this.cartModel});
  final CartModel cartModel;
  @override
  List<Object> get props => [];
}
