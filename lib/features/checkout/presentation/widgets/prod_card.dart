import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:flutter/material.dart';

class ProdCard extends StatelessWidget {
  const ProdCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
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
                      Icons.more_horiz,
                    ),
                    onPressed: () {},
                  ),
                  const Text('X3'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
