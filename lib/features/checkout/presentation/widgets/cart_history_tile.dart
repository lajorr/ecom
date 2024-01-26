// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/presentation/screens/cart_history_screen.dart';
import 'package:flutter/material.dart';

class CartHistoryTile extends StatelessWidget {
  const CartHistoryTile({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          CartHistoryScreen.routeName,
          arguments: cart,
        );
      },
      child: Container(
        width: media.width * 0.33,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Text(
            "total: ${cart.amount}",
          ),
          Text(
            "items: ${cart.products.length}",
          ),
        ]),
      ),
    );
  }
}
