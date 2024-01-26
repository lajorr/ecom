import 'package:ecom/features/checkout/presentation/blocs/orders%20bloc/orders_bloc.dart';
import 'package:ecom/features/checkout/presentation/widgets/cart_history_tile.dart';
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

    context.read<OrdersBloc>().add(
          FetchOrderHistoryEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is OrderFetchFailed) {
          return Text(state.message ?? "fail");
        }
        if (state is OrderFetchSuccess) {
          final cartList = state.order.cartList;

          return SizedBox(
            height: media.height * 0.18,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Order History"),
                SizedBox(
                  height: media.height * 0.01,
                ),
                if (cartList.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        final cart = cartList[index];

                        return CartHistoryTile(cart: cart);
                      },
                    ),
                  ),
                if (cartList.isEmpty)
                  const Center(
                    child: Text("No History Yet"),
                  )
              ],
            ),
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
