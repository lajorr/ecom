import 'package:ecom/features/checkout/presentation/blocs/orders%20bloc/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    super.initState();

    print("order history widget");

    context.read<OrdersBloc>().add(
          FetchOrderHistoryEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is CheckoutFetchOrderSuccess) {
          print("has data");
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order History"),
            ],
          );
        }
        if (state is CheckoutOrderLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text("ELSEE"),
          );
        }
      },
    );
  }
}
