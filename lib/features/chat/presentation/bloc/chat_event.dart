part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatEvent {
  const SendMessageEvent({required this.message});
  final MessageModel message;
}

class FetchMessagesEvent extends ChatEvent {
  const FetchMessagesEvent({required this.otherUserId});
  final String otherUserId;
}

class FetchChatRoomsEvent extends ChatEvent {}
