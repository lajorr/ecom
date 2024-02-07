// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/chat/data/model/message_model.dart';
import 'package:ecom/features/chat/presentation/widgets/message%20tile/msg_tile_self.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.owner,
    required this.currentUser,
  }) : super(key: key);

  static const routeName = '/chat-screen';

  final UserModel owner;
  final UserModel currentUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  String message = '';

  final List<MessageModel> _messages = [];
  void onSend() {
    final msg = MessageModel(
      reciever: widget.owner,
      sender: widget.currentUser,
      message: message,
      createdAt: DateTime.now(),
    );
    _messages.add(msg);
    _textController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
            Text(widget.owner.name!),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ..._messages
                        .map(
                          (msgM) => MsgTileSelf(
                            message: msgM.message,
                            createdAt: msgM.createdAt,
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ),
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
      ),
    );
  }
}
