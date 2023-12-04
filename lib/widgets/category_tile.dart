// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:ecom/constants/img_uri.dart';

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
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.white,
          border: Border.all(
            color: const Color(0xffEDEDED),
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // icon
          // Icon(Icons.add),
          Image.asset(
            getImageUri(iconUri),
          ),
          const SizedBox(
            width: 5,
          ),
          //title
          Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
