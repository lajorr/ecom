import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'language_tile.dart';

class ChangeLanguageDialog extends StatefulWidget {
  const ChangeLanguageDialog({
    Key? key,
    required this.media,
  }) : super(key: key);

  final Size media;

  @override
  State<ChangeLanguageDialog> createState() => _ChangeLanguageDialogState();
}

class _ChangeLanguageDialogState extends State<ChangeLanguageDialog> {
  final List<Map<String, dynamic>> languages = [
    {
      "lang": "english",
      "locale": const Locale('en', 'US'),
    },
    {
      "lang": "japanese",
      "locale": const Locale('ja', 'JPN'),
    },
  ];

  @override
  Widget build(BuildContext context) {
    int selectedIndex;
    if (context.locale == const Locale("ja", "JPN")) {
      selectedIndex = 1;
    } else {
      selectedIndex = 0;
    }
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: widget.media.height * 0.22,
          width: widget.media.height * 0.2,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final lang = (languages[index]['lang'] as String).tr();
              final locale = languages[index]['locale'] as Locale;

              return GestureDetector(
                onTap: () {
                  context.setLocale(locale);
                },
                child: LanguageTile(
                  media: widget.media,
                  language: lang,
                  isSelected: selectedIndex == index,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
