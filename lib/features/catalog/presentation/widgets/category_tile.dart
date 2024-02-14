// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecom/constants/img_uri.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required this.iconUri,
    required this.title,
    this.isActive = false,
  }) : super(key: key);

  final String iconUri;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xffEDEDED),
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isActive
            ? const [
                BoxShadow(
                  color: Color.fromARGB(48, 41, 37, 38),
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(0, 3),
                )
              ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          ),
        ],
      ),
    );
  }
}
