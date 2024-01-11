part of 'like_bloc.dart';

sealed class LikeState extends Equatable {
  const LikeState();
}

final class LikeLoading extends LikeState {
  @override
  List<Object> get props => [];
}

final class LikeSuccess extends LikeState {
  final bool isLiked;

  const LikeSuccess({required this.isLiked});

  @override
  List<Object> get props => [];
}

final class LikeFailed extends LikeState {
  @override
  List<Object> get props => [];
}

final class LikeStatusChange extends LikeState {
  final bool isLiked;

  const LikeStatusChange({required this.isLiked});
  @override
  List<Object> get props => [];
}
