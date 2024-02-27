import 'package:ecom/features/checkout/domain/entity/enums/cart_status_enum.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/prod_detail/presentation/screens/details_screen.dart';
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
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];

        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              DetailsScreen.routeName,
              arguments: {
                "product": product.product,
                "currentUser": cart.user,
              },
            );
          },
          child: ProdCard(
            cartProduct: product,
            isOrderPlaced: cart.cartStatus == CartStatus.orderPlaced,
          ),
        );
      },
    );
  }
}
