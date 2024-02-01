// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/presentation/widgets/cart_bill_widget.dart';
import 'package:flutter/material.dart';

import '../../../payment/presentation/widgets/shipping_card.dart';
import '../widgets/cart_products_widget.dart';

class CartHistoryScreen extends StatelessWidget {
  const CartHistoryScreen({
    Key? key,
    required this.cart,
  }) : super(key: key);

  static const routeName = '/cart-history';

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CartProductsWidget(
              cart: cart,
            ),
            Expanded(
              child: Column(
                children: [
                  const ShippingCard(),
                  CartBillWidget(
                    productList: cart.products,
                    cart: cart,
                    shippingFee: 0.0,
                    totalAmt: cart.amount,
                  ),
                  Text("lat: ${cart.lat}"),
                  Text("lng: ${cart.lng}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
