// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/checkout/domain/entity/enums/cart_status_enum.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:flutter/material.dart';

import 'prod_card.dart';

class CartProductsWidget extends StatelessWidget {
  const CartProductsWidget({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    final productList = cart.products;
    return Expanded(
      child: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];

          return Column(
            children: [
              ProdCard(
                cartProduct: product,
                isOrderPlaced: cart.cartStatus == CartStatus.orderPlaced,
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
