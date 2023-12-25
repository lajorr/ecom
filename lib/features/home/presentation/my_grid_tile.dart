// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/common/widgets/like_button.dart';
import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/features/prod_detail/presentation/details_screen.dart';
import 'package:ecom/shared/product/model/product_global_model.dart';
import 'package:flutter/material.dart';

class MyGridTile extends StatelessWidget {
  const MyGridTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    void onCardTap() {
      Navigator.of(context).pushNamed(
        DetailsScreen.routeNmae,
        arguments: product,
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
                child: Image.network(
                  product.prodImage[0].imageUrl,
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
