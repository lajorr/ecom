part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();
}

final class PaymentInitial extends PaymentState {
  @override
  List<Object> get props => [];
}

final class PaymentInfoLoading extends PaymentState {
  @override
  List<Object> get props => [];
}

final class PaymentInfoFetchSuccess extends PaymentState {
  const PaymentInfoFetchSuccess({required this.creditM});
  final CreditCardModel creditM;

  @override
  List<Object> get props => [creditM];
}

final class PaymentInfoFetchFailed extends PaymentState {
  @override
  List<Object> get props => [];
}

final class PaymentInfoAddSuccess extends PaymentState {
  @override
  List<Object> get props => [];
}

final class PaymentInfoAddLoading extends PaymentState {
  @override
  List<Object> get props => [];
}

final class PaymentInfoAddFailed extends PaymentState {
  @override
  List<Object> get props => [];
}
