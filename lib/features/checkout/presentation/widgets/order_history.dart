import '../../../../common/widgets/my_shimmer.dart';
import '../blocs/orders%20bloc/orders_bloc.dart';
import 'cart_history_tile.dart';
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
        } else if (state is OrderFetchSuccess) {
          final cartList = state.order.cartList.reversed.toList();

          return SizedBox(
            height: media.height * 0.2,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: media.height * 0.02,
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
        } else if (state is CheckoutOrderLoading) {
          return OrderShimmer(media: media);
        } else {
          return const Center(
            child: Text("ELSEE"),
          );
        }
      },
    );
  }
}

class OrderShimmer extends StatelessWidget {
  const OrderShimmer({
    super.key,
    required this.media,
  });

  final Size media;

  @override
  Widget build(BuildContext context) {
    return MyShimmer(
      child: Container(
        height: media.height * 0.2,
        margin: EdgeInsets.only(top: media.height * 0.01),
        child: ListView.builder(
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: media.width * 0.5,
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 20,
                width: 50,
                color: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }
}
