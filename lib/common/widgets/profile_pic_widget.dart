import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/common/widgets/my_shimmer.dart';
import 'package:ecom/constants/img_uri.dart';
import 'package:flutter/material.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({
    required this.imageUrl, required this.size, super.key,
  });

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
