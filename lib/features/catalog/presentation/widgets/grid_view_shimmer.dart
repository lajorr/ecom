import 'package:ecom/common/widgets/my_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridViewShimmer extends StatelessWidget {
  const GridViewShimmer({
    Key? key,
    required this.media,
    required this.height,
  }) : super(key: key);

  final Size media;
  final double height;

  @override
  Widget build(BuildContext context) {
    return MyShimmer(
      child: SizedBox(
        height: height,
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: media.height * 0.28,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(
                  height: media.height * 0.01,
                ),
                Container(
                  height: media.height * 0.025,
                  width: media.width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: media.height * 0.01,
                ),
                Container(
                  height: media.height * 0.015,
                  width: media.width * 0.125,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: media.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: media.height * 0.025,
                      width: media.width * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: media.height * 0.025,
                      width: media.width * 0.125,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
