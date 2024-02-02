import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePickerDialog extends StatefulWidget {
  const ProfilePickerDialog({
    Key? key,
    required this.onPressedOk,
  }) : super(key: key);

  final Function(Uint8List) onPressedOk;

  @override
  State<ProfilePickerDialog> createState() => _ProfilePickerDialogState();
}

class _ProfilePickerDialogState extends State<ProfilePickerDialog> {
  final ImagePicker picker = ImagePicker();
  Uint8List? _image;

  Future<void> pickImage(ImageSource source) async {
    XFile? imageFile = await picker.pickImage(
      source: source,
      imageQuality: 15
    );
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
            child: const Text('Gallery'),
          ),
          TextButton(
            onPressed: () => pickImage(ImageSource.camera),
            child: const Text('Camera'),
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
          child: const Text('Cancel'),
        ),
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
                const SnackBar(
                  content: Text('Select an image...'),
                  duration: Duration(milliseconds: 1000),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const Text(
            'OK',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
