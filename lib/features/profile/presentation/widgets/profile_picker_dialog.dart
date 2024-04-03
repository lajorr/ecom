import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePickerDialog extends StatefulWidget {
  const ProfilePickerDialog({
    required this.onPressedOk, super.key,
  });

  final Function(Uint8List) onPressedOk;

  @override
  State<ProfilePickerDialog> createState() => _ProfilePickerDialogState();
}

class _ProfilePickerDialogState extends State<ProfilePickerDialog> {
  final ImagePicker picker = ImagePicker();
  Uint8List? _image;

  Future<void> pickImage(ImageSource source) async {
    final imageFile = await picker.pickImage(source: source, imageQuality: 15);
    if (imageFile != null) {
      _image = await imageFile.readAsBytes();
      setState(() {});
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: media.height * 0.1,
            height: media.height * 0.1,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: _image == null
                ? Container()
                : Image(
                    image: MemoryImage(_image!),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () => pickImage(ImageSource.gallery),
            child: const Text(StringConstants.galleryText).tr(),
          ),
          TextButton(
            onPressed: () => pickImage(ImageSource.camera),
            child: const Text(StringConstants.cameraText).tr(),
          ),
        ],
      ),
      actions: [
        MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(StringConstants.cancelText).tr(),),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          color: Theme.of(context).primaryColor,
          onPressed: () async {
            if (_image != null) {
              widget.onPressedOk(_image!);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(StringConstants.selectImageText).tr(),
                  duration: const Duration(milliseconds: 1000),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const Text(
            StringConstants.okText,
            style: TextStyle(
              color: Colors.white,
            ),
          ).tr(),
        ),
      ],
    );
  }
}
