import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/profile_pic_widget.dart';
import '../../../auth/data/model/user_model.dart';
import '../../data/model/message_model.dart';
import '../blocs/chat bloc/chat_bloc.dart';
import '../widgets/file_type_widget.dart';
import '../widgets/message tile/msg_tile_other.dart';
import '../widgets/message tile/msg_tile_self.dart';
import '../widgets/my_text_box.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.otherUser,
    required this.currentUserId,
  }) : super(key: key);

  static const routeName = '/chat-screen';

  final UserModel otherUser;
  final String currentUserId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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

  bool showFileTypes = false;

  @override
  Widget build(BuildContext context) {
    List<MessageModel> messages = [];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            ProfilePicWidget(
              imageUrl: widget.otherUser.imageUrl,
              size: 0.06,
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
          if (state is ChatFetching) {
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
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        StreamBuilder<List<MessageModel>>(
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
                                    if (message.senderId ==
                                        widget.currentUserId) {
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
                        if (showFileTypes) const FileTypesWidget(),
                      ],
                    ),
                  ),
                  MyTextBox(
                    otherUserId: widget.otherUser.uid!,
                    currentUserId: widget.currentUserId,
                    onFileTapped: () {
                      setState(() {
                        showFileTypes = !showFileTypes;
                      });
                    },
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
