// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/widgets/like_button.dart';
import 'package:flutter/material.dart';

import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/screens/prod_info.dart';
import 'package:ecom/widgets/my_button.dart';
import 'package:ecom/widgets/product_size.dart';
import 'package:ecom/widgets/rounded_button.dart';
import 'package:ecom/widgets/show_cart_button.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
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
                    height: 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        getImageUri(product.image),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                      ),
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
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),

              // size
              const ProductSize(),

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
                          text: "Add To Cart",
                          iconUri: shopCart,
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
