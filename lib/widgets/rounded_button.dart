// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ecom/constants/img_uri.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    this.iconUri,
  }) : super(key: key);

  final String text;
  final String? iconUri;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff292526),
        borderRadius: BorderRadius.circular(30),
      ),
      // alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          if (iconUri != null)
          Image.asset(
            getImageUri(
              iconUri!,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
