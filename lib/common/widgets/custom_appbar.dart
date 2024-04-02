// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/common/widgets/my_button.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    required this.title, required this.actions, super.key,
    this.backButton = true,
  });

  final String title;
  final bool backButton;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (backButton)
            const Flexible(
              flex: 2,
              child: MyButton(
                size: 40,
                dropShadow: false,
              ),
            ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          if (actions.isNotEmpty) ...actions,
        ],
      ),
    );
  }
}
