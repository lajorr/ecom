import 'dart:io';

import 'package:ecom/features/chat/presentation/widgets/pick_image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'file_type_tile.dart';

class FileTypesWidget extends StatelessWidget {
  const FileTypesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: GridView.count(
          crossAxisCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const FileTypeTile(fileType: 'Document'),
            GestureDetector(
              onTap: () {
                ImagePicker()
                    .pickImage(source: ImageSource.camera)
                    .then((value) {
                  File? file = File(value!.path);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return PickImageDialog(file: file);
                    },
                  );
                });
              },
              child: const FileTypeTile(fileType: 'Camera'),
            ),
            GestureDetector(
              onTap: () async {
                final imageXFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
              },
              child: const FileTypeTile(fileType: 'Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
