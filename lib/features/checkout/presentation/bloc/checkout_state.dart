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
  @override
  List<Object> get props => [];
}
