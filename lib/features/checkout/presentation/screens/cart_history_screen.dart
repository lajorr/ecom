import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/presentation/widgets/cart_bill_widget.dart';
import 'package:ecom/features/checkout/presentation/widgets/cart_products_widget.dart';
import 'package:ecom/features/payment/presentation/widgets/shipping_card.dart';
import 'package:flutter/material.dart';

class CartHistoryScreen extends StatelessWidget {
  const CartHistoryScreen({
    required this.cart, super.key,
  });

  static const routeName = '/cart-history';

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.historyTitleText).tr(),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
                    shippingFee: 0,
                    totalAmt: cart.amount,
                  ),
                  const Text(StringConstants.deliveryLocText)
                      .tr(args: ['${cart.address}']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
