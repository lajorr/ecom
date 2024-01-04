import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/img_uri.dart';
import '../../../../constants/string_constants.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //intro
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringConstants.welcomeUserText,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  (state is ProfileLoaded)
                      ? state.username ?? "John Doe"
                      : "...",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.start,
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
      },
    );
  }
}
