part of 'like_bloc.dart';

sealed class LikeState extends Equatable {
  const LikeState();
}

final class LikeInitial extends LikeState {
  @override
  List<Object> get props => [];
}
final class LikeLoading extends LikeState {
  @override
  List<Object> get props => [];
}

final class LikeSuccess extends LikeState {

  const LikeSuccess({required this.isLiked});
  final bool isLiked;

  @override
  List<Object> get props => [];
}

final class LikeFailed extends LikeState {
  @override
  List<Object> get props => [];
}

final class LikeStatusChange extends LikeState {

  const LikeStatusChange({required this.isLiked});
  final bool isLiked;
  @override
  List<Object> get props => [];
}
