// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecom/features/profile/presentation/widgets/profile_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String? imageUrl;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final ImagePicker picker = ImagePicker();
  Uint8List? image;
  String? imageUrl;

  void onConfirmImage(Uint8List imageBytes) {
    setState(() {
      image = imageBytes;
    });

    context
        .read<ProfileBloc>()
        .add(UploadProfilePictureEvent(image: imageBytes));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded || state is ProfilePictureUploadSuccess) {
          String? imgUrl;
          Uint8List? uintImage;
          if (state is ProfileLoaded) {
            imgUrl = state.currentUser.imageUrl;
          } else if (state is ProfilePictureUploadSuccess) {
            uintImage = image;
          }

          return Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                    height: media.height * 0.12,
                    width: media.height * 0.12,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: imgUrl == null && uintImage == null
                        ? Container()
                        : imgUrl != null && uintImage == null
                            ? CachedNetworkImage(
                                imageUrl: imgUrl,
                                fit: BoxFit.cover,
                              )
                            : imgUrl == null && uintImage != null
                                ? Image(
                                    image: MemoryImage(image!),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  )
                                : Container()
                    //  image == null
                    //     ? Container()
                    //     : Image(
                    //         image: MemoryImage(image!),
                    //         fit: BoxFit.cover,
                    //         alignment: Alignment.topCenter,
                    //       ),
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
                      showDialog(
                        context: context,
                        builder: (context) =>
                            ProfilePickerDialog(onPressedOk: onConfirmImage),
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
        } else if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text('Else'),
          );
        }
      },
    );
  }
}
