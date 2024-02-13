// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/chat/data/model/message_model.dart';
import 'package:ecom/features/chat/presentation/blocs/cubit/show_send_button_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/chat bloc/chat_bloc.dart';
import '../widgets/message tile/msg_tile_other.dart';
import '../widgets/message tile/msg_tile_self.dart';

// tyo state change vayo vane error audainaaa...

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.otherUser,
    required this.currentUser,
  }) : super(key: key);

  static const routeName = '/chat-screen';

  final UserModel otherUser;
  final UserModel currentUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context
        .read<ChatBloc>()
        .add(FetchMessagesEvent(otherUserId: widget.otherUser.uid!));
  }

  @override
  void deactivate() {
    BlocProvider.of<ChatBloc>(context).add(DisposeMessageStreamEvent());
    super.deactivate();
  }

  void onSend() {
    final msg = MessageModel(
      message: _textController.text.trim(),
      createdAt: DateTime.now(),
      recieverId: widget.otherUser.uid!,
      senderId: widget.currentUser.uid!,
    );
    context.read<ChatBloc>().add(SendMessageEvent(message: msg));
    _textController.clear();
    context
        .read<ShowSendButtonCubit>()
        .toggleSendVisibility(_textController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    List<MessageModel> messages = [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        toolbarHeight: 70,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.amber,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.otherUser.name!),
          ],
        ),
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatUploaded) {
            context
                .read<ChatBloc>()
                .add(FetchMessagesEvent(otherUserId: widget.otherUser.uid!));
          }
        },
        builder: (context, state) {
          if (state is ChatFetching || state is ChatStoring) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChatFailed) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ChatLoaded) {
            final msgStream = state.messageStream;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Expanded(
                  child: StreamBuilder<List<MessageModel>>(
                      stream: msgStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          final messageM = snapshot.data!;
                          messages = messageM.reversed.toList();

                          return ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              if (message.senderId == widget.currentUser.uid) {
                                return MsgTileSelf(
                                  message: message.message,
                                  createdAt: message.createdAt,
                                );
                              } else {
                                return MsgTileOther(
                                  message: message.message,
                                  createdAt: message.createdAt,
                                );
                              }
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.bottomCenter,
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintText: "Write a message..",
                      suffixIcon:
                          BlocBuilder<ShowSendButtonCubit, ShowSendButtonState>(
                        builder: (context, state) {
                          if (state is ShowSendButtonTrue) {
                            return IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: onSend,
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                    onChanged: (value) {
                      context
                          .read<ShowSendButtonCubit>()
                          .toggleSendVisibility(value);
                    },
                    onEditingComplete: onSend,
                  ),
                ),
              ]),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
