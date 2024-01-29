// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/features/payment/data/model/credit_card_model.dart';
import 'package:ecom/features/payment/domain/usecase/add_card_details_usecase.dart';
import 'package:ecom/features/payment/domain/usecase/fetch_credit_card_details_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({
    required this.addCardDetailsUsecase,
    required this.fetchCreditCardDetailsUsecase,
  }) : super(PaymentInitial()) {
    on<AddPaymentDetailsEvent>(_onAddPaymentInfo);
    on<FetchCreditCardInfoEvent>(_onFetchCreditCardInfo);
  }

  final AddCardDetailsUsecase addCardDetailsUsecase;
  final FetchCreditCardDetailsUsecase fetchCreditCardDetailsUsecase;

  FutureOr<void> _onAddPaymentInfo(
      AddPaymentDetailsEvent event, Emitter<PaymentState> emit) async {
    emit(PaymentInfoAddLoading());

    final addOrFail = await addCardDetailsUsecase.call(event.creditCardModel);

    addOrFail.fold((failure) => emit(PaymentInfoAddFailed()), (_) {
      emit(PaymentInfoAddSuccess());
    });
  }

  FutureOr<void> _onFetchCreditCardInfo(
      FetchCreditCardInfoEvent event, Emitter<PaymentState> emit) async {
    emit(PaymentInfoLoading());
    final fetchOrFail = await fetchCreditCardDetailsUsecase.call(NoParams());

    fetchOrFail.fold(
        (failure) => emit(
              PaymentInfoFetchFailed(),
            ), (creditM) {
      emit(PaymentInfoFetchSuccess(
        creditM: creditM,
      ));
    });
  }
}
