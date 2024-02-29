import 'package:flutter/material.dart';

class FileTypeTile extends StatelessWidget {
  const FileTypeTile({
    Key? key,
    required this.fileType,
  }) : super(key: key);

  final String fileType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 35,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(fileType),
      ],
    );
  }
}
