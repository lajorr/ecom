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

    print("fetching ....");
    context.read<CheckoutBloc>().add(FetchCartProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CheckoutLoaded) {
              final productList = state.cartProductList;
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // prod list
                  if (productList.isEmpty)
                    const SizedBox(
                      child: Center(
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total(9 Items)",
                      ),
                      Text('.0'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping Fee"),
                      Text('.00'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sub Total "),
                      Text('.0'),
                    ],
                  ),
                  RoundedButton(
                    text: "Pay",
                    onTap: () {},
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
