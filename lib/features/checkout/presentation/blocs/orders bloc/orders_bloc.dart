// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/domain/model/order_model.dart';
import 'package:ecom/features/checkout/domain/usecases/fetch_order_usecase.dart';
import 'package:ecom/features/checkout/domain/usecases/place_order_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

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
      FetchOrderHistoryEvent event, Emitter<OrdersState> emit,) async {
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
      OrderCartItemsEvent event, Emitter<OrdersState> emit,) async {
    emit(CheckoutOrderLoading());

    final cM = event.cartModel;
    final lat = cM.lat;
    final lng = cM.lng;
    final address = await placemarkFromCoordinates(
      lat!,
      lng!,
    );
    final subLocality = address.first.subLocality!;
    final cMA = cM.copyWith(address: subLocality);

    final payOrFail = await placeOrderUsecase.call(cMA);
    payOrFail.fold((failure) {
      emit(
        OrderPaymentFailed(message: failure.message),
      );
    }, (_) {
      emit(
        const OrderPaymentSuccess(
            message: StringConstants.paymentSuccessfulText,),
      );
    });
  }
}
