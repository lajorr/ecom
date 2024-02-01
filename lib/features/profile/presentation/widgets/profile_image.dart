import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    super.key,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: media.height * 0.12,
            width: media.height * 0.12,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: image == null
                ? Container()
                : Image(
                    image: XFileImage(image!),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: -5,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Theme.of(context).primaryColor,
            child: IconButton(
              onPressed: () async {
                print('tapped');
                image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                setState(() {});
              },
              icon: const Icon(
                Icons.photo_camera,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}
