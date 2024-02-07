import 'package:flutter/material.dart';

class MsgTileOther extends StatelessWidget {
  const MsgTileOther({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: media.width * 0.45,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10,
              ),
              child: Text('Hi'),
            ),
          ),
          const Text(
            "12/4",
            style: TextStyle(
              fontSize: 11,
            ),
          )
        ],
      ),
    );
  }
}
