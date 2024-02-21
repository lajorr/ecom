import 'package:flutter/material.dart';

import '../../../../constants/img_uri.dart';
import '../../../checkout/presentation/screens/checkout_screen.dart';

class ShowCartButton extends StatelessWidget {
  const ShowCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(CheckoutScreen.routeName);

       
      },
      child: Container(
        height: 60,
        margin: const EdgeInsets.only(
          left: 10,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          ImageConstants.getImageUri(ImageConstants.shopCart),
        ),
      ),
    );
  }
}
