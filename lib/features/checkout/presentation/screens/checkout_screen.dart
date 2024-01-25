import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/string_constants.dart';
import '../../../../injection_container.dart';
import '../../../prod_detail/presentation/widgets/shipping_card.dart';
import '../blocs/checkoutbloc/checkout_bloc.dart';
import '../blocs/orders bloc/orders_bloc.dart';
import '../widgets/order_history.dart';
import '../widgets/prod_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static const routeName = '/checkout';

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();

    print(context.read<CheckoutBloc>().state);
  }

  @override
  Widget build(BuildContext context) {
    const shippingFee = 0.00;
    final media = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => sl<OrdersBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                context.read<CheckoutBloc>().add(PayForCartEvent());
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(StringConstants.paymentSuccessfulText),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              icon: const Icon(Icons.payment),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<CheckoutBloc, CheckoutState>(
            listener: (context, state) {
              if (state is CheckoutAddSuccess) {
                context.read<CheckoutBloc>().add(FetchCartProductsEvent());
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
  }
}
