part of 'like_bloc.dart';

sealed class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}

class LikeButtonPressedEvent extends LikeEvent {

  const LikeButtonPressedEvent({required this.prodId});
  final String prodId;
}

// class CreateLikeDocumentEvent extends LikeEvent {}

class FetchLikeDocumentEvent extends LikeEvent {

  const FetchLikeDocumentEvent({required this.prodId});
  final String prodId;
}
