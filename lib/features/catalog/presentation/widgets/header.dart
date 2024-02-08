import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/img_uri.dart';
import '../../../../constants/string_constants.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
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
                    state.currentUser.name ?? '...',
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
                child: 
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: (state.currentUser.imageUrl != null)
                        ? CachedNetworkImage(
                            imageUrl: state.currentUser.imageUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: Shimmer.fromColors(
                                baseColor: Colors.red,
                                highlightColor: Colors.yellow,
                                child: Container(
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Image.asset(
                            ImageConstants.getImageUri(
                                ImageConstants.profilePic),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          )),
              
              
              )
            ],
          );
        } else if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text('else'),
          );
        }
      },
    );
  }
}
