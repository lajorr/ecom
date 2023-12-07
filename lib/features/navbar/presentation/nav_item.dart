// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ecom/constants/img_uri.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    Key? key,
    required this.iconUri,
    required this.onTap,
  }) : super(key: key);

  final String iconUri;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: const Color.fromARGB(255, 65, 60, 61),
        child: Image.asset(
          ImageConstants.getImageUri(iconUri),
        ),
      ),
    );
  }
}
