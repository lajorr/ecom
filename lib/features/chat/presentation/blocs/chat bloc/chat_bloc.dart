import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../auth/data/model/user_model.dart';
import '../../../data/model/message_model.dart';
import '../../../domain/usecase/fetch_chat_room_data_usecase.dart';
import '../../../domain/usecase/fetch_messages_usecase.dart';
import '../../../domain/usecase/send_message_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    required this.sendMessageUsecase,
    required this.fetchMessagesUsecase,
    required this.fetchChatRoomDataUsecase,
  }) : super(ChatInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<FetchMessagesEvent>(_onFetchMessage);
    on<FetchChatRoomsEvent>(_onFetchChatRooms);
  }

  final SendMessageUsecase sendMessageUsecase;
  final FetchMessagesUsecase fetchMessagesUsecase;
  final FetchChatRoomDataUsecase fetchChatRoomDataUsecase;

  Stream<List<MessageModel>> messageStream = const Stream.empty();

  FutureOr<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    final sentOrFail = await sendMessageUsecase.call(event.message);
    sentOrFail.fold(
        (failure) => emit(
              ChatFailed(message: failure.message),
            ), (_) {
      emit(ChatUploaded());
    });
  }

  FutureOr<void> _onFetchMessage(
      FetchMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatFetching());
    final fetchOrFail = await fetchMessagesUsecase.call(event.otherUserId);

    fetchOrFail.fold(
        (failure) => emit(
              ChatFailed(message: failure.message),
            ), (messages) {
      messageStream = messages;
      emit(
        ChatLoaded(messageStream: messageStream),
      );
    });
  }

  FutureOr<void> _onFetchChatRooms(
      FetchChatRoomsEvent event, Emitter<ChatState> emit) async {
    emit(ChatRoomLoading());
    final fetchOrFail = await fetchChatRoomDataUsecase.call(NoParams());
    fetchOrFail.fold(
      (failure) => emit(
        ChatRoomFailed(
          message: failure.message,
        ),
      ),
      (userList) {
        emit(
          ChatRoomLoaded(
            userList: userList,
          ),
        );
      },
    );
  }
}
