import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/chat/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
    required this.otherUser,
    required this.currentUser,
  }) : super(key: key);

  final UserModel? otherUser;
  final UserModel currentUser;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: otherUser == null
          ? null
          : () {
              Navigator.of(context).pushNamed(
                ChatScreen.routeName,
                arguments: {
                  "other_user": otherUser!,
                  "current_user": currentUser,
                },
              );
            },
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          otherUser != null ? Icons.messenger : Icons.comments_disabled_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}