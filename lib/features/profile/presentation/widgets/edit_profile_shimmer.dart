import 'package:flutter/material.dart';

class EditProfileShimmer extends StatelessWidget {
  const EditProfileShimmer({
    required this.media, super.key,
  });

  final Size media;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: media.height * 0.02,
        ),
        Center(
          child: Container(
            height: media.height * 0.12,
            width: media.height * 0.12,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(media.width * 0.5),
            ),
          ),
        ),
        SizedBox(
          height: media.height * 0.05,
        ),
        Container(
          height: media.height * 0.02,
          width: media.width * 0.2,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(
          height: media.height * 0.005,
        ),
        Container(
          height: media.height * 0.075,
          // width: media.height * 0.12,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(
          height: media.height * 0.005,
        ),
        Container(
          height: media.height * 0.02,
          width: media.width * 0.2,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(
          height: media.height * 0.005,
        ),
        Container(
          height: media.height * 0.075,
          // width: media.height * 0.12,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(
          height: media.height * 0.08,
        ),
        Center(
          child: Container(
            height: media.height * 0.045,
            width: media.width * 0.22,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}
