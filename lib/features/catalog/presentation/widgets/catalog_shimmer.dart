import 'package:flutter/material.dart';

import '../../../../common/widgets/my_shimmer.dart';
import 'grid_view_shimmer.dart';

class CatalogShimmer extends StatelessWidget {
  const CatalogShimmer({
    super.key,
    required this.media,
  });

  final Size media;

  @override
  Widget build(BuildContext context) {
    return MyShimmer(
      child: Column(
        children: [
          //search
          Container(
            height: media.height * 0.07,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: media.height * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],
            ),
          ),
          // cat list
          Container(
            height: media.height * 0.07,
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: media.width * 0.25,
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: media.height * 0.01,
          ),
          GridViewShimmer(
            media: media,
            height: media.height * 0.57,
          ),
        ],
      ),
    );
  }
}
