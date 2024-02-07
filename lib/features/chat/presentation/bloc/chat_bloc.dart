// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/features/chat/data/model/message_model.dart';
import 'package:ecom/features/chat/domain/usecase/fetch_messages_usecase.dart';
import 'package:ecom/features/chat/domain/usecase/send_message_usecase.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    required this.sendMessageUsecase,
    required this.fetchMessagesUsecase,
  }) : super(ChatInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<FetchMessagesEvent>(_onFetchMessage);
  }

  final SendMessageUsecase sendMessageUsecase;
  final FetchMessagesUsecase fetchMessagesUsecase;

  FutureOr<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final sentOrFail = await sendMessageUsecase.call(event.message);
    sentOrFail.fold(
        (failure) => emit(
              ChatFailed(message: failure.message),
            ), (_) {
      print("success");
      emit(ChatUploaded());
    });
  }

  FutureOr<void> _onFetchMessage(
      FetchMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final fetchOrFail = await fetchMessagesUsecase.call(event.otherUserId);

    fetchOrFail.fold(
        (failure) => emit(
              ChatFailed(message: failure.message),
            ), (messages) {
      print("fetch Sucess");
      emit(
        ChatLoaded(userMessages: messages),
      );
    });
  }
}
