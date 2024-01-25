// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/features/checkout/domain/usecases/fetch_order_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domain/model/order_model.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc({
    required this.fetchOrderUsecase,
  }) : super(OrdersInitial()) {
    on<FetchOrderHistoryEvent>(_onFetchOrderHistory);
  }

  final FetchOrderUsecase fetchOrderUsecase;

  FutureOr<void> _onFetchOrderHistory(
      FetchOrderHistoryEvent event, Emitter<OrdersState> emit) async {
    print("fetch order bloc");
    emit(CheckoutOrderLoading());
    final fetchOrFail = await fetchOrderUsecase.call(NoParams());
    fetchOrFail.fold(
      (failure) => emit(CheckoutFetchOrderFailed()),
      (orderM) {
        print("bloc success state");
        emit(
          CheckoutFetchOrderSuccess(
            order: orderM,
          ),
        );
      },
    );
  }
}
