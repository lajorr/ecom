import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/features/chat/data/model/message_model.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendMessageEvent>(_onSendMessage);
  }

  FutureOr<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) {

        
      }
}
