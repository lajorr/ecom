// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/features/catalog/presentation/blocs/like%20bloc/like_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({
    Key? key,
    required this.prodId,
    required this.isFav,
  }) : super(key: key);

  final String prodId;
  final bool isFav;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool isFav;
  @override
  void initState() {
    super.initState();
    isFav = widget.isFav;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFav = !isFav;
        });

        BlocProvider.of<LikeBloc>(context)
            .add(LikeButtonPressedEvent(prodId: widget.prodId));
      },
      child: BlocConsumer<LikeBloc, LikeState>(
        listener: (context, state) {
          if (state is LikeSuccess) {
            isFav = state.isLiked;
          }
        },
        builder: (context, state) {
          if (state is LikeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LikeSuccess) {
            return CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).primaryColor,
              child: Image.asset(
                ImageConstants.getImageUri(
                  isFav
                      ? ImageConstants.favIcon
                      : ImageConstants.likeIconOutline,
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
