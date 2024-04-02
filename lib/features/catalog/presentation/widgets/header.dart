import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/my_shimmer.dart';
import '../../../../common/widgets/profile_pic_widget.dart';
import '../../../../constants/string_constants.dart';
import '../../../navbar/presentation/cubit/nav_index_cubit.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(FetchUserDataEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
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
                  ).tr(),
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
          return HeaderShimmer(media: media);
        } else {
          return const Center(
            child: Text('else'),
          );
        }
      },
    );
  }
}

class HeaderShimmer extends StatelessWidget {
  const HeaderShimmer({
    super.key,
    required this.media,
  });

  final Size media;

  @override
  Widget build(BuildContext context) {
    return MyShimmer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: media.height * 0.02,
                width: media.width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(media.width * 0.5),
                ),
              ),
              SizedBox(
                height: media.height * 0.01,
              ),
              Container(
                height: media.height * 0.02,
                width: media.width * 0.2,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(media.width * 0.5),
                ),
              ),
            ],
          ),
          Container(
            height: media.height * 0.08,
            width: media.height * 0.08,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(media.width * 0.5),
            ),
          )
        ],
      ),
    );
  }
}
