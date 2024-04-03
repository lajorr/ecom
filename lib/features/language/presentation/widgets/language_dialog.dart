import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/features/language/presentation/widgets/language_tile.dart';
import 'package:flutter/material.dart';

class ChangeLanguageDialog extends StatefulWidget {
  const ChangeLanguageDialog({

      Key? key,
  }) : super(key: key);




  @override
  State<ChangeLanguageDialog> createState() => _ChangeLanguageDialogState();
}

class _ChangeLanguageDialogState extends State<ChangeLanguageDialog> {
  final List<Map<String, dynamic>> languages = [
    {
      'lang': 'english',
      'locale': const Locale('en', 'US'),
    },
    {
      'lang': 'japanese',
      'locale': const Locale('ja', 'JPN'),
    },
  ];

  @override
  Widget build(BuildContext ctx) {
    int selectedIndex;
    if (context.locale == const Locale('ja', 'JPN')) {
      selectedIndex = 1;
    } else {
      selectedIndex = 0;
    }
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.height * 0.2,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: languages.length,
            itemBuilder: (ctx, index) {
              final lang = (languages[index]['lang'] as String).tr();
              final locale = languages[index]['locale'] as Locale;

              return GestureDetector(
                onTap: () async {
                  await context.setLocale(locale);

                },
                child: LanguageTile(
                  media:  MediaQuery.of(context).size,
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
