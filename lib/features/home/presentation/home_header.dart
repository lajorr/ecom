import '../../../constants/img_uri.dart';
import '../../../constants/string_constants.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //intro
        Column(
          children: [
            Text(
              StringConstants.welcomeUserText,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              StringConstants.username,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        //avatar
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              ImageConstants.getImageUri(ImageConstants.profilePic),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        )
      ],
    );
  }
}
