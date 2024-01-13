import '../../domain/entity/cart_product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/checkout_bloc.dart';

class ProdCard extends StatelessWidget {
  const ProdCard({
    Key? key,
    required this.cartProduct,
  }) : super(key: key);

  final CartProduct cartProduct;

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
                          product.category,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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

                      context.read<CheckoutBloc>().add(
                            FetchCartProductsEvent(),
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
