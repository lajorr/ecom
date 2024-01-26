part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}

final class OrderFetchSuccess extends OrdersState {
  const OrderFetchSuccess({required this.order});
  final OrderModel order;

  @override
  List<Object> get props => [];
}

final class OrderFetchFailed extends OrdersState {
  const OrderFetchFailed({required this.message});
  final String? message;
  @override
  List<Object> get props => [];
}

final class CheckoutOrderLoading extends OrdersState {
  @override
  List<Object> get props => [];
}

final class OrderPaymentSuccess extends OrdersState {
  const OrderPaymentSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [];
}

final class OrderPaymentFailed extends OrdersState {
  const OrderPaymentFailed({required this.message});
  final String message;
  @override
  List<Object> get props => [];
}
