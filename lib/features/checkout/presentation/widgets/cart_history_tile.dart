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

    final products = cart.products;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          CartHistoryScreen.routeName,
          arguments: cart,
        );
      },
      child: Container(
        width: media.width * 0.5,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Items",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Quantity",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: media.height * 0.005,
            ),
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final prod = products[index];
                  if (index < 2) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: media.width * 0.25,
                          child: Text(
                            prod.product.prodTitle,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'X${prod.quantity}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }
                  return null;
                },
              ),
            ),
            if (products.length > 2)
              const Text(
                "..more",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
