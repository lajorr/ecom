
import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/constants/string_constants.dart';

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
  void didChangeDependencies() {
        final getLocal = context.locale;
    context.setLocale(getLocal);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is OrderFetchFailed) {
          return Text(state.message ?? 'fail');
        } else if (state is OrderFetchSuccess) {
          final cartList = state.order.cartList.reversed.toList();

          return SizedBox(
            height: media.height * 0.25,
            // width: double.infinity,
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

                 Center(
                    child: const Text(StringConstants.noHistory).tr(),
                  )

              ],
            ),
          );
        } else if (state is CheckoutOrderLoading) {
          return OrderShimmer(media: media);
        } else {
          return const Center(
            child: Text('ELSEE'),
          );
        }
      },
    );
  }
}
