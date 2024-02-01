part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class FetchOrderHistoryEvent extends OrdersEvent {}

class OrderCartItemsEvent extends OrdersEvent {
  const OrderCartItemsEvent({required this.cartModel});
  final CartModel cartModel;
}
