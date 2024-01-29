// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/string_constants.dart';
import '../../../../injection_container.dart';
import '../../../payment/presentation/widgets/shipping_card.dart';
import '../blocs/checkoutbloc/checkout_bloc.dart';
import '../blocs/orders bloc/orders_bloc.dart';
import '../widgets/cart_bill_widget.dart';
import '../widgets/cart_products_widget.dart';
import '../widgets/order_history.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    const shippingFee = 0.00;
    final media = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => sl<OrdersBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          extendBody: true,
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
                          CartProductsWidget(
                            cart: cart,
                          ),

                        //shipping info
                        const ShippingCard(),

                        // total amount
                        CartBillWidget(
                          productList: productList,
                          cart: cart,
                          shippingFee: shippingFee,
                          totalAmt: totalAmt,
                        ),
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
