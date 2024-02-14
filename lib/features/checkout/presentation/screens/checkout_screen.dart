import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/string_constants.dart';
import '../../../payment/presentation/widgets/shipping_card.dart';
import '../blocs/checkoutbloc/checkout_bloc.dart';
import '../blocs/orders bloc/orders_bloc.dart';
import '../widgets/cart_bill_widget.dart';
import '../widgets/cart_products_widget.dart';
import '../widgets/payment_dialog.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    const shippingFee = 0.00;
    final media = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return BlocListener<OrdersBloc, OrdersState>(
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
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is CheckoutFetchFailed) {
              return const Scaffold(
                body: Center(
                  child: Text(StringConstants.dataFetchErrorText),
                ),
              );
            } else if (state is CheckoutLoaded) {
              final cart = state.cartModel;

              final productList = cart.products;

              final totalAmt = shippingFee + cart.amount;

              return Scaffold(
                extendBody: true,
                appBar: AppBar(
                  title: const Text('Checkout'),
                  backgroundColor: Colors.transparent,
                  actions: [
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) =>
                              PaymentDialog(ctx: context, cartModel: cart),
                        );
                      },
                      child: const Text("Pay"),
                    )
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
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
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('ELSe'),
              );
            }
          },
        ),
      );
    });
  }
}
