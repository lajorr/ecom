import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/constants/products.dart';
import 'package:ecom/widgets/my_button.dart';
import 'package:ecom/widgets/prod_card.dart';
import 'package:ecom/widgets/rounded_button.dart';
import 'package:ecom/widgets/shipping_card.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButton(
                    size: 40,
                    dropShadow: false,
                  ),
                  Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  MyButton(
                    size: 40,
                    dropShadow: false,
                    iconUri: moreIcon,
                  ),
                ],
              ),

              // prod list
              SizedBox(
                height: 350,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const ProdCard(),
                        if (index < 2) const Divider(),
                      ],
                    );
                  },
                ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sub Total "),
                        Text('\$131.0'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
