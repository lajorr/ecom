import 'package:ecom/common/widgets/custom_appbar.dart';
import 'package:ecom/common/widgets/rounded_button.dart';
import 'package:ecom/features/home/data/product_provider.dart';
import 'package:ecom/common/widgets/prod_card.dart';
import 'package:ecom/features/prod_detail/presentation/shipping_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // app bar
              const CustomAppbar(title: 'Checkout'),

              // prod list
              SizedBox(
                height: 350,
                child: Consumer<ProductProvider>(builder: (context, prodP, _) {
                  final productList = prodP.productList;
                  return ListView.builder(
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
                  );
                }),
              ),
              //shipping info
              const ShippingCard(),

              // total amount
              const Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total(9 Items)",
                        ),
                        Text('\$131.0'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Shipping Fee"),
                        Text('\$0.00'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(height: 30),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sub Total "),
                          Text('\$131.0'),
                        ],
                      ),
                    ),
                    RoundedButton(text: "Pay"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
