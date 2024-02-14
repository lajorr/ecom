// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/cart_product_entity.dart';
import '../blocs/checkoutbloc/checkout_bloc.dart';

class ProdCard extends StatelessWidget {
  const ProdCard({
    Key? key,
    required this.cartProduct,
    required this.isOrderPlaced,
  }) : super(key: key);

  final CartProduct cartProduct;
  final bool isOrderPlaced;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    final product = cartProduct.product;
    return Column(
      children: [
        Container(
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              // image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.prodImage[0].imageUrl,
                  fit: BoxFit.cover,
                  width: media.width * 0.2,
                  height: media.height * 0.1,
                ),
              ),
              SizedBox(
                width: media.width * 0.02,
              ),
              //info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          product.prodTitle,
                        ),
                        Text(
                          product.category.name,
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Text(
                      '\$${product.price.toString()}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: isOrderPlaced
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (!isOrderPlaced)
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () {
                        context.read<CheckoutBloc>().add(
                              RemoveProdFromCartEvent(
                                prod: product,
                              ),
                            );
                      },
                    ),
                  Text('X${cartProduct.quantity}'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
