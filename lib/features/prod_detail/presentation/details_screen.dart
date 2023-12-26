// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/common/widgets/like_button.dart';
import 'package:ecom/common/widgets/my_button.dart';
import 'package:ecom/common/widgets/rounded_button.dart';
import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/prod_detail/presentation/prod_info.dart';
import 'package:ecom/features/prod_detail/presentation/product_size.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:flutter/material.dart';

import 'show_cart_button.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    // required this.product,
  }) : super(key: key);

  // final Product product;

  static const routeNmae = '/prod-detail';

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;

    final media = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              //image
              Stack(
                children: [
                  SizedBox(
                    height: media.height * 0.5,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: product.prodImage.length,
                      itemBuilder: (context, index) {
                        final image = product.prodImage[index];

                        return SizedBox(
                          width: media.width - 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              image.imageUrl,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyButton(
                          size: 50,
                          dropShadow: true,
                        ),
                        LikeButton(
                          product: product,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              //title row
              ProdInfo(product: product),

              Divider(
                height: media.height * 0.07,
              ),

              // size
              ProductSize(product: product),

              // add to cart button

              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: RoundedButton(
                          text: StringConstants.addToCartText,
                          iconUri: ImageConstants.shopCart,
                        ),
                      ),
                      ShowCartButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
