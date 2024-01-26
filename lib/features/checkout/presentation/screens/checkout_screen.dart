import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/string_constants.dart';
import '../../../../injection_container.dart';
import '../../../prod_detail/presentation/widgets/shipping_card.dart';
import '../blocs/checkoutbloc/checkout_bloc.dart';
import '../blocs/orders bloc/orders_bloc.dart';
import '../widgets/order_history.dart';
import '../widgets/prod_card.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    const shippingFee = 0.00;
    final media = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => sl<OrdersBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Checkout'),
            backgroundColor: Colors.transparent,
            actions: [
              TextButton(
                onPressed: () {
                  context.read<OrdersBloc>().add(OrderCartItemsEvent());

                },
                child: const Text("Pay"),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocListener<OrdersBloc, OrdersState>(
              listener: (context, state) {
                if (state is OrderPaymentSuccess) {
                  context.read<CheckoutBloc>().add(FetchCartProductsEvent());
                  // context.read<OrdersBloc>().add(FetchOrderHistoryEvent());

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                if (state is OrderPaymentFailed) {
                  context.read<OrdersBloc>().add(FetchOrderHistoryEvent());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: BlocConsumer<CheckoutBloc, CheckoutState>(
                listener: (context, state) {
                  if (state is CheckoutAddSuccess) {
                    context.read<CheckoutBloc>().add(FetchCartProductsEvent());
                  }

                  if (state is CheckoutRemoveItemSuccess) {
                    print("DElete success State");
                    context.read<CheckoutBloc>().add(
                          FetchCartProductsEvent(),
                        );
                  }
                },
                builder: (context, state) {
                  if (state is CheckoutLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CheckoutFetchFailed) {
                    return const Center(
                      child: Text(StringConstants.dataFetchErrorText),
                    );
                  } else if (state is CheckoutLoaded) {
                    final cart = state.cartModel;

                    print(cart);

                    final productList = cart.products;

                    final totalAmt = shippingFee + cart.amount;
                    return Column(
                      children: [
                        // prod list
                        if (productList.isEmpty)
                          SizedBox(
                            height: media.height * 0.2,
                            child: const Center(
                              child: Text(StringConstants.emptyProductListText),
                            ),
                          )
                        else
                          Expanded(
                            child: ListView.builder(
                              itemCount: productList.length,
                              itemBuilder: (context, index) {
                                final product = productList[index];

                                return Column(
                                  children: [
                                    ProdCard(
                                      cartProduct: product,
                                    ),
                                    const Divider(),
                                  ],
                                );
                              },
                            ),
                          ),

                        //shipping info
                        const ShippingCard(),

                        // total amount
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total(${productList.length} Items)",
                            ),
                            Text('\$${cart.amount}'),
                          ],
                        ),
                        SizedBox(height: media.height * 0.01),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(StringConstants.shippingFeeText),
                            Text('\$$shippingFee'),
                          ],
                        ),
                        SizedBox(height: media.height * 0.01),
                        const Divider(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(StringConstants.subTotalText),
                            Text('\$${totalAmt.toStringAsFixed(2)}'),
                          ],
                        ),
                        SizedBox(height: media.height * 0.02),
                        Builder(builder: (context) {
                          return const OrderHistory();
                        }),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
