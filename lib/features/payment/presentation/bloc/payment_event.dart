part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class AddPaymentDetailsEvent extends PaymentEvent {
  const AddPaymentDetailsEvent({required this.creditCardModel});
  final CreditCardModel creditCardModel;
}

class FetchCreditCardInfoEvent extends PaymentEvent {}
