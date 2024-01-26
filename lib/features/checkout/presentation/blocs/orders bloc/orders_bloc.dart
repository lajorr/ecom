// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/features/checkout/domain/usecases/fetch_order_usecase.dart';
import 'package:ecom/features/checkout/domain/usecases/place_order_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../../constants/string_constants.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/model/order_model.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc({
    required this.fetchOrderUsecase,
    required this.placeOrderUsecase,
  }) : super(OrdersInitial()) {
    on<FetchOrderHistoryEvent>(_onFetchOrderHistory);
    on<OrderCartItemsEvent>(_onPayForCartEvent);
  }

  final FetchOrderUsecase fetchOrderUsecase;
  final PlaceOrderUsecase placeOrderUsecase;

  FutureOr<void> _onFetchOrderHistory(
      FetchOrderHistoryEvent event, Emitter<OrdersState> emit) async {
    emit(CheckoutOrderLoading());
    final fetchOrFail = await fetchOrderUsecase.call(NoParams());
    fetchOrFail.fold(
      (failure) => emit(OrderFetchFailed(message: failure.message)),
      (orderM) {
        emit(
          OrderFetchSuccess(
            order: orderM,
          ),
        );
      },
    );
  }

  FutureOr<void> _onPayForCartEvent(
      OrderCartItemsEvent event, Emitter<OrdersState> emit) async {
    emit(CheckoutOrderLoading());

    final payOrFail = await placeOrderUsecase.call(NoParams());
    payOrFail.fold((failure) {
      emit(
        OrderPaymentFailed(message: failure.message),
      );
    }, (_) {
      emit(
        const OrderPaymentSuccess(
            message: StringConstants.paymentSuccessfulText),
      );
    });
  }
}
