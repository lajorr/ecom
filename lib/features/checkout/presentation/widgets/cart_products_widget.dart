import 'package:ecom/features/checkout/domain/entity/enums/cart_status_enum.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/presentation/widgets/prod_card.dart';
import 'package:ecom/features/prod_detail/presentation/screens/details_screen.dart';
import 'package:flutter/material.dart';

class CartProductsWidget extends StatelessWidget {
  const CartProductsWidget({
    required this.cart, super.key,
  });

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    final productList = cart.products;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                DetailsScreen.routeName,
                arguments: {
                  'product': product.product,
                  'currentUser': cart.user,
                },
              );
            },
            child: ProdCard(
              cartProduct: product,
              isOrderPlaced: cart.cartStatus == CartStatus.orderPlaced,
            ),
          );
        },
      ),
    );
  }
}
