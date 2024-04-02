import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/domain/model/cart_product_model.dart';
import 'package:flutter/material.dart';

class CartBillWidget extends StatelessWidget {
  const CartBillWidget({
    required this.productList, required this.cart, required this.shippingFee, required this.totalAmt, super.key,
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
              ).tr(args: ['${productList.length}']),
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
