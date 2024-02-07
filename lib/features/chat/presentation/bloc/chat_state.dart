part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
}

final class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

final class ChatLoading extends ChatState {
  @override
  List<Object> get props => [];
}

final class ChatLoaded extends ChatState {
  @override
  List<Object> get props => [];
}

final class ChatFailed extends ChatState {
  @override
  List<Object> get props => [];
}
