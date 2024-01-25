part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();
  
  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}

final class CheckoutFetchOrderSuccess extends OrdersState {
  const CheckoutFetchOrderSuccess({required this.order});
  final OrderModel order;

  @override
  List<Object> get props => [];
}

final class CheckoutFetchOrderFailed extends OrdersState {
  @override
  List<Object> get props => [];
}

final class CheckoutOrderLoading extends OrdersState {
  @override
  List<Object> get props => [];
}