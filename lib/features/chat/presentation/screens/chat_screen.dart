// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/chat/data/model/message_model.dart';
import 'package:ecom/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/message tile/msg_tile_other.dart';
import '../widgets/message tile/msg_tile_self.dart';

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
  String message = '';

  @override
  void initState() {
    super.initState();

    context
        .read<ChatBloc>()
        .add(FetchMessagesEvent(otherUserId: widget.otherUser.uid!));
  }

  void onSend() {
    final msg = MessageModel(
      reciever: widget.otherUser,
      sender: widget.currentUser,
      message: message,
      createdAt: DateTime.now(),
    );
    context.read<ChatBloc>().add(SendMessageEvent(message: msg));
    setState(() {
      // _messages.add(msg);
      _textController.clear();
    });
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
      body: BlocBuilder<ChatBloc, ChatState>(
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

                          return Expanded(
                            child: ListView.builder(
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                if (message.sender == widget.currentUser) {
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
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    hintText: "Write a message..",
                    suffixIcon: _textController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: onSend,
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      message = value;
                    });
                  },
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
