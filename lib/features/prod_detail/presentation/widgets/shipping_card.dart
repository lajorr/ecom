import 'package:flutter/material.dart';

import '../../../../constants/img_uri.dart';

class ShippingCard extends StatelessWidget {
  const ShippingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping Information',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xffF6F6F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    ImageConstants.getImageUri(ImageConstants.visaIcon),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('**** **** **** 2143'),
                ],
              ),
              const Icon(
                Icons.keyboard_arrow_down_sharp,
                size: 32,
              )
            ],
          ),
        )
      ],
    );
  }
}
