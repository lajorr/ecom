// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MsgTileSelf extends StatelessWidget {
  const MsgTileSelf({
    required this.message, required this.createdAt, super.key,
  });

  final String message;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: media.width * 0.45,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Text(
            DateFormat('Hm').format(createdAt),
            style: const TextStyle(
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
