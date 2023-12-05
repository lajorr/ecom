// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/services/product_provider.dart';
import 'package:flutter/material.dart';

import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/models/product.dart';
import 'package:provider/provider.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final prodP = Provider.of<ProductProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        prodP.changeFav(product);
        prodP.getFavProd();
      },
      child: Consumer<ProductProvider>(builder: (context, prodP, _) {
        return CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Image.asset(
            getImageUri(
              product.isFav ? favIcon : heartIcon,
            ),
          ),
        );
      }),
    );
  }
}
