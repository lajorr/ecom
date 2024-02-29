// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/message_model.dart';
import '../../domain/entity/message_enity.dart';
import '../blocs/chat bloc/chat_bloc.dart';
import '../blocs/cubit/show_send_button_cubit.dart';

class MyTextBox extends StatefulWidget {
  const MyTextBox({
    Key? key,
    required this.otherUserId,
    required this.currentUserId,
    required this.onFileTapped,
  }) : super(key: key);

  @override
  State<MyTextBox> createState() => _MyTextBoxState();
  final String otherUserId;
  final String currentUserId;
  final VoidCallback onFileTapped;
}

class _MyTextBoxState extends State<MyTextBox> {
  final TextEditingController _textController = TextEditingController();

  void onSend() {
    if (_textController.text.isNotEmpty) {
      final msg = MessageModel(
          message: _textController.text.trim(),
          createdAt: DateTime.now(),
          recieverId: widget.otherUserId,
          senderId: widget.currentUserId,
          messageType: MessageType.text);
      context.read<ChatBloc>().add(SendMessageEvent(message: msg));
      _textController.clear();
      context.read<ShowSendButtonCubit>().toggleSendVisibility(
            _textController.text.trim(),
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.bottomCenter,
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          hintText: "Write a message..",
          prefixIcon: IconButton(
            icon: const Icon(Icons.file_present_rounded),
            onPressed: widget.onFileTapped,
          ),
          suffixIcon: BlocBuilder<ShowSendButtonCubit, ShowSendButtonState>(
            builder: (context, state) {
              if (state is ShowSendButtonTrue) {
                final brightness = Theme.of(context).brightness;
                return IconButton(
                  icon: Icon(
                    Icons.send,
                    color: brightness == Brightness.light
                        ? Theme.of(context).primaryColor
                        : Colors.white,
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
          context.read<ShowSendButtonCubit>().toggleSendVisibility(value);
        },
        onEditingComplete: onSend,
      ),
    );
  }
}
