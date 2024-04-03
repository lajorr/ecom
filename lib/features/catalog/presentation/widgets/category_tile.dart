// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecom/constants/img_uri.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    required this.iconUri, required this.title, super.key,
    this.isActive = false,
  });

  final String iconUri;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(
        right: 10,
        top: 5,
        bottom: 5,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Theme.of(context).colorScheme.secondary,
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // icon
          Image.asset(
            ImageConstants.getImageUri(iconUri),
          ),
          const SizedBox(
            width: 5,
          ),
          //title
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
