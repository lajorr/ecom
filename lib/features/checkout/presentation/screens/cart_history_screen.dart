import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../constants/string_constants.dart';
import '../../../payment/presentation/widgets/shipping_card.dart';
import '../../domain/model/cart_model.dart';
import '../widgets/cart_bill_widget.dart';
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
        title: const Text(StringConstants.historyTitleText).tr(),
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
                  const Text(StringConstants.deliveryLocText)
                      .tr(args: ['${cart.address}']),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
