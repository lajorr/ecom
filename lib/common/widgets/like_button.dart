import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/features/catalog/presentation/blocs/like%20bloc/like_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({
    Key? key,
    required this.prodId,
  }) : super(key: key);

  final String prodId;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with TickerProviderStateMixin {
  bool isFav = false;
  late bool likeLoaded;
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    context.read<LikeBloc>().add(FetchLikeDocumentEvent(prodId: widget.prodId));
    likeLoaded = false;
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            likeLoaded = true;
          }
        },
        builder: (context, state) {
          if (state is LikeLoading) {
            return Container();
          } else if (state is LikeSuccess) {
            return FadeTransition(
              opacity: _animation,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).primaryColor,
                child: Image.asset(
                  ImageConstants.getImageUri(
                    isFav
                        ? ImageConstants.favIcon
                        : ImageConstants.likeIconOutline,
                  ),
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
