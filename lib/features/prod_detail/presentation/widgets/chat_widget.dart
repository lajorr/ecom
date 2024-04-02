import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:flutter/material.dart';

import '../../../auth/data/model/user_model.dart';
import '../../../chat/presentation/screens/chat_screen.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
    required this.otherUser,
    required this.currentUserId,
  }) : super(key: key);

  final UserModel? otherUser;
  final String currentUserId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: otherUser == null
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  duration: const Duration(seconds: 1),
                  content: const Text(
                    StringConstants.noOwnerText,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ).tr(),
                ),
              );
            }
          : () {
              Navigator.of(context).pushNamed(
                ChatScreen.routeName,
                arguments: {
                  "other_user": otherUser!,
                  "current_user_id": currentUserId,
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
