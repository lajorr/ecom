import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../constants/string_constants.dart';
import '../../domain/model/cart_model.dart';
import '../../domain/model/cart_product_model.dart';

class CartBillWidget extends StatelessWidget {
  const CartBillWidget({
    super.key,
    required this.productList,
    required this.cart,
    required this.shippingFee,
    required this.totalAmt,
  });

  final List<CartProductModel> productList;
  final CartModel cart;

  final double shippingFee;
  final double totalAmt;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                StringConstants.totalProdText,
              ).tr(args: ["${productList.length}"]),
              Text('\$${cart.amount}'),
            ],
          ),
          SizedBox(height: media.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(StringConstants.shippingFeeText).tr(),
              Text('\$$shippingFee'),
            ],
          ),
          SizedBox(height: media.height * 0.01),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(StringConstants.subTotalText).tr(),
              Text('\$${totalAmt.toStringAsFixed(2)}'),
            ],
          ),
          SizedBox(height: media.height * 0.02),
        ],
      ),
    );
  }
}
