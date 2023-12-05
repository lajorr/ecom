// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/constants/products.dart';
import 'package:flutter/material.dart';

import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/models/product.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          changeFav(widget.product);
        });
      },
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Theme.of(context).primaryColor,
        child: Image.asset(
          getImageUri(
            widget.product.isFav ? favIcon : heartIcon,
          ),
        ),
      ),
    );
  }
}
