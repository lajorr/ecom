import 'package:flutter/material.dart';

import '../../../../common/widgets/my_shimmer.dart';

class ChatRoomShimmer extends StatelessWidget {
  const ChatRoomShimmer({
    super.key,
    required this.media,
  });

  final Size media;

  @override
  Widget build(BuildContext context) {
    return MyShimmer(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(16),
            height: media.height * 0.1,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }
}
