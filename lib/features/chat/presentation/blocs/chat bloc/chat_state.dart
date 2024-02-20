part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
}

final class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

final class ChatFetching extends ChatState {
  @override
  List<Object> get props => [];
}

final class ChatStoring extends ChatState {
  @override
  List<Object?> get props => [];
}

final class ChatLoaded extends ChatState {
  const ChatLoaded({required this.messageStream});
  final Stream<List<MessageModel>> messageStream;

  @override
  List<Object> get props => [
        messageStream,
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

final class ChatRoomLoading extends ChatState {
  @override
  List<Object?> get props => [];
}

final class ChatRoomLoaded extends ChatState {
  const ChatRoomLoaded({
    required this.userList,
  });

  final List<UserModel> userList;

  @override
  List<Object?> get props => [userList];
}

final class ChatRoomFailed extends ChatState {
  const ChatRoomFailed({required this.message});
  final String message;
  @override
  List<Object?> get props => [
        message,
      ];
}

final class ChatDisposed extends ChatState {
  @override
  List<Object?> get props => [];
}
