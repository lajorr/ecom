// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/constants/img_uri.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.size,
    required this.dropShadow,
    this.iconUri = ImageConstants.backArrow,
  }) : super(key: key);

  final double size;
  final bool dropShadow;

  final String iconUri;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: !dropShadow
              ? Border.all(
                  color: Colors.grey.shade300,
                )
              : Border.all(
                  style: BorderStyle.none,
                ),
          color: Colors.white,
          boxShadow: [
            if (dropShadow)
              const BoxShadow(
                color: Color.fromARGB(58, 0, 0, 0),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
          ],
        ),
        child: Image.asset(
          ImageConstants.getImageUri(iconUri),
        ),
      ),
    );
  }
}
