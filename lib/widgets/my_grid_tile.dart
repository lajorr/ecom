// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/screens/details_screen.dart';
import 'package:ecom/widgets/like_button.dart';
import 'package:flutter/material.dart';

import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/models/product.dart';

class MyGridTile extends StatelessWidget {
  const MyGridTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    void onCardTap() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailsScreen(
            product: product,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onCardTap,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment,
        children: [
          //image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  getImageUri(product.image),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: LikeButton(
                  product: product,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              //vcategory
              Text(
                product.category,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //price
                  Text("\$${product.price.toString()}"),
                  Row(
                    children: [
                      Image.asset(
                        getImageUri(starIcon),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('${product.rating}'),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
