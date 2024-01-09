import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:flutter/material.dart';

import '../widgets/prod_card.dart';
import '../../../../common/widgets/rounded_button.dart';
import '../../../prod_detail/presentation/widgets/shipping_card.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // prod list
            FutureBuilder(
                future: FireCollections().getAllProductsFromCollection(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final productList = snapshot.data!;
                    return SizedBox(
                      height: media.height * 0.4,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          final product = productList[index];

                          return Column(
                            children: [
                              ProdCard(
                                product: product,
                              ),
                              if (index < 2) const Divider(),
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            //shipping info
            const ShippingCard(),

            // total amount
            Expanded(
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total(9 Items)",
                      ),
                      Text('\$131.0'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping Fee"),
                      Text('\$0.00'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(height: 30),
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sub Total "),
                        Text('\$131.0'),
                      ],
                    ),
                  ),
                  RoundedButton(
                    text: "Pay",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
