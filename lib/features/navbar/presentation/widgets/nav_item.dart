
import '../../../../constants/img_uri.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    Key? key,
    required this.iconUri,
    required this.bgColor,
    required this.onTap,
  }) : super(key: key);

  final String iconUri;
  final Color bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: bgColor,
        child: Image.asset(
          ImageConstants.getImageUri(iconUri),
        ),
      ),
    );
  }
}

