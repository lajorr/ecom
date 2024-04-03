import 'package:ecom/common/widgets/my_shimmer.dart';
import 'package:flutter/material.dart';

class OrderShimmer extends StatelessWidget {
  const OrderShimmer({
    required this.media, super.key,
  });

  final Size media;

  @override
  Widget build(BuildContext context) {
    return MyShimmer(
      child: Container(
        height: media.height * 0.2,
        margin: EdgeInsets.only(top: media.height * 0.01),
        child: ListView.builder(
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: media.width * 0.5,
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 20,
                width: 50,
                color: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }
}
