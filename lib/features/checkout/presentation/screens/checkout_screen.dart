import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/rounded_button.dart';
import '../../../prod_detail/presentation/widgets/shipping_card.dart';
import '../bloc/checkout_bloc.dart';
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
    // context.read<CheckoutBloc>().add(FetchCartProductsEvent());
    print(context.read<CheckoutBloc>().state);
  }

  @override
  Widget build(BuildContext context) {
    const shippingFee = 0.00;
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.transparent,
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
            } else if (state is CheckoutPaymentSuccess) {
              return const Center(
                child: Text("Your Items will be delivered shortly"),
              );
            } else if (state is CheckoutFetchFailed) {
              return const Center(
                child: Text("Something went wrong while fetching data"),
              );
            } else if (state is CheckoutLoaded) {
              final cart = state.cartModel;

              // print("SCreen $cart");
              final productList = cart.products;
              print("DATA SCreen ${cart.amount}");

              final totalAmt = shippingFee + cart.amount;
              print("DATA SCREEN total $totalAmt");

              return Column(
                children: [
                  // prod list
                  if (productList.isEmpty)
                    SizedBox(
                      height: media.height * 0.2,
                      child: const Center(
                        child: Text('Add Products to your Cart ...'),
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
                      Text("Shipping Fee"),
                      Text('\$$shippingFee'),
                    ],
                  ),
                  SizedBox(height: media.height * 0.01),
                  const Divider(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Sub Total "),
                      Text('\$${totalAmt.toStringAsFixed(2)}'),
                    ],
                  ),
                  SizedBox(height: media.height * 0.05),
                  RoundedButton(
                    text: "Pay",
                    onTap: () {
                      context.read<CheckoutBloc>().add(PayForCartEvent());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Payment Successful'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
