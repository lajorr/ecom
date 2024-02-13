import 'package:ecom/common/widgets/profile_pic_widget.dart';
import 'package:ecom/features/navbar/presentation/cubit/nav_index_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              GestureDetector(
                onTap: () {
                  context.read<NavIndexCubit>().onChangeNavIndex(3);
                },
                child: ProfilePicWidget(
                  imageUrl: state.currentUser.imageUrl,
                  size: 0.08,
                ),
              ),
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
