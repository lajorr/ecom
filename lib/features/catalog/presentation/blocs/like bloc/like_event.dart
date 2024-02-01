part of 'like_bloc.dart';

sealed class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}

class LikeButtonPressedEvent extends LikeEvent {
  final String prodId;

  const LikeButtonPressedEvent({required this.prodId});
}

// class CreateLikeDocumentEvent extends LikeEvent {}

class FetchLikeDocumentEvent extends LikeEvent {
  final String prodId;

  const FetchLikeDocumentEvent({required this.prodId});
}
