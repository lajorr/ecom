// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    Key? key,
    required this.media,
    required this.language,
    required this.isSelected,
  }) : super(key: key);

  final Size media;
  final String language;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            height: media.height * 0.05,
            width: media.height * 0.05,
            child: isSelected
                ? const Center(
                    child: Icon(Icons.done),
                  )
                : null,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(language),
        ],
      ),
    );
  }
}
