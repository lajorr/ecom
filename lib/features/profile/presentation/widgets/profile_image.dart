import 'dart:typed_data';

import 'package:ecom/common/widgets/profile_pic_widget.dart';
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded || state is ProfilePictureUploadSuccess) {
          String? imgUrl;

          if (state is ProfileLoaded) {
            imgUrl = state.currentUser.imageUrl;
          }

          return Stack(
            clipBehavior: Clip.none,
            children: [
              ProfilePicWidget(imageUrl: imgUrl, size: 0.12),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(50),
              //   child: Container(
              //     height: media.height * 0.12,
              //     width: media.height * 0.12,
              //     color: Theme.of(context).colorScheme.primaryContainer,
              //     child: imgUrl == null && uintImage == null
              //         ? Container()
              //         : imgUrl != null && uintImage == null
              //             ? CachedNetworkImage(
              //                 imageUrl: imgUrl,
              //                 fit: BoxFit.cover,
              //               )
              //             : imgUrl == null && uintImage != null
              //                 ? Image(
              //                     image: MemoryImage(image!),
              //                     fit: BoxFit.cover,
              //                     alignment: Alignment.topCenter,
              //                   )
              //                 : Container(),
              //   ),
              // ),

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
