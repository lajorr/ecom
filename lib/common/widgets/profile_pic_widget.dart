import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/img_uri.dart';
import 'my_shimmer.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({
    Key? key,
    required this.imageUrl,
    required this.size,
  }) : super(key: key);

  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SizedBox(
      width: media.height * size,
      height: media.height * size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(media.width * 0.5),
        child: (imageUrl != null)
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: MyShimmer(
                    child: Container(
                      height: media.height * size,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              )
            : Image.asset(
                ImageConstants.getImageUri(ImageConstants.profilePic),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
      ),
    );
  }
}
