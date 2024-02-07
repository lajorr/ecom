import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/chat/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
    required this.owner,
    required this.currentUser,
  }) : super(key: key);

  final UserModel? owner;
  final UserModel currentUser;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: owner == null
          ? null
          : () {
              Navigator.of(context).pushNamed(
                ChatScreen.routeName,
                arguments: {
                  "owner": owner!,
                  "current_user": currentUser,
                },
              );
            },
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          owner != null ? Icons.messenger : Icons.comments_disabled_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}
