import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/presentation/screens/cart_history_screen.dart';
import 'package:flutter/material.dart';

class CartHistoryTile extends StatelessWidget {
  const CartHistoryTile({
    required this.cart, super.key,
  });

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
          width: media.width * 0.4,
          margin: const EdgeInsets.only(right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GridTile(
              footer: Container(
                height: 70,
                padding: const EdgeInsets.all(10),
                color: const Color.fromARGB(155, 0, 0, 0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringConstants.itemsText,
                        style: Theme.of(context).textTheme.displaySmall,
                      ).tr(),
                      Text(
                        'X${products.length}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: media.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringConstants.total,
                        style: Theme.of(context).textTheme.displaySmall,
                      ).tr(),
                      Text(
                        '\$${cart.amount}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ],),
              ),
              child: CachedNetworkImage(
                imageUrl: products[0].product.prodImage[0].imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),);
  }
}
