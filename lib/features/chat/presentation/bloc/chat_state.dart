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
  const ChatLoaded({required this.userMessages});
  final List<MessageModel> userMessages;

  @override
  List<Object> get props => [
        userMessages,
      ];
}

final class ChatUploaded extends ChatState {
  @override
  List<Object?> get props => [];
}

final class ChatFailed extends ChatState {
  const ChatFailed({required this.message});
  final String message;

  @override
  List<Object> get props => [
        message,
      ];
}
