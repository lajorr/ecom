import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/screens/checkout_screen.dart';
import 'package:flutter/material.dart';

class ShowCartButton extends StatelessWidget {
  const ShowCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CheckoutScreen(),
          ),
        );
      },
      child: Container(
        height: 60,
        margin: const EdgeInsets.only(
          left: 10,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff292526),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          getImageUri(shopCart),
        ),
      ),
    );
  }
}
