// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../prod_detail/presentation/screens/details_screen.dart';

class MyGridTile extends StatelessWidget {
  const MyGridTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DetailsScreen.routeName, arguments: product);
      },
      child: Column(
        children: [
          //image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: product.prodImage[0].imageUrl,
              placeholder: (context, url) => Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.red,
                  highlightColor: Colors.yellow,
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(
                product.prodTitle,
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
                        ImageConstants.getImageUri(ImageConstants.starIcon),
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
