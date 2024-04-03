import 'dart:typed_data';

import 'package:ecom/common/widgets/my_shimmer.dart';
import 'package:ecom/common/widgets/profile_pic_widget.dart';
import 'package:ecom/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecom/features/profile/presentation/widgets/profile_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    required this.imageUrl, super.key,
  });

  final String? imageUrl;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final ImagePicker picker = ImagePicker();
  Uint8List? image;
  String? imageUrl;

  void onConfirmImage(Uint8List imageBytes) {
    
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
        if (state is ProfileLoaded) {
          String? imgUrl;

          imgUrl = state.currentUser.imageUrl;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              ProfilePicWidget(imageUrl: imgUrl, size: 0.12),
              Positioned(
                bottom: 5,
                right: -5,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    onPressed: () async {
                      await showDialog(
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
              ),
            ],
          );
        } else if (state is ProfileLoading) {
          return Center(
            child: MyShimmer(
              child: Container(
                height: media.height * 0.12,
                width: media.height * 0.12,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(media.width * 0.5),
                ),
              ),
            ),
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
