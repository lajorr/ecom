import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/img_uri.dart';
import '../../../../constants/string_constants.dart';
import '../../../payment/presentation/widgets/shipping_card.dart';
import '../blocs/checkoutbloc/checkout_bloc.dart';
import '../blocs/cubit/credit_card_set_cubit.dart';
import '../blocs/orders bloc/orders_bloc.dart';
import '../widgets/cart_bill_widget.dart';
import '../widgets/cart_products_widget.dart';
import '../widgets/checkout_shimmer.dart';
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
        builder: (ctx, state) {
          if (state is CheckoutLoading) {
            return Scaffold(

              body: CheckoutShimmer(media: media),
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
                  BlocBuilder<CreditCardSetCubit, CreditCardSetState>(
                    builder: (context, state) {
                      if (state is CreditCardSetTrue) {
                        return TextButton(
                          onPressed: () {
                            showDialog(
                              context: ctx,
                              builder: (ctx) =>
                                  PaymentDialog(ctx: ctx, cartModel: cart),
                            );
                          },
                          child: const Text("Pay"),
                        );
                      } else {
                        return Container();
                      }
                    },
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
                        height: media.height * 0.25,
                        child: Column(
                          children: [
                            Image.asset(
                              ImageConstants.getImageUri(
                                  ImageConstants.emptyCartIcon),
                              height: media.height * 0.1,
                            ),
                            SizedBox(
                              height: media.height * 0.03,
                            ),
                            const Text(
                              '... products where?',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
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
  }
}
