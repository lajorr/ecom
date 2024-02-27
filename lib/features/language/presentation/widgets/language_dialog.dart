import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/features/language/presentation/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_tile.dart';

class ChangeLanguageDialog extends StatelessWidget {
  ChangeLanguageDialog({
    Key? key,
    required this.media,
  }) : super(key: key);

  final Size media;

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
    return AlertDialog(
      content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: media.height * 0.22,
            width: media.height * 0.2,
            child: BlocBuilder<LanguageCubit, LanguageState>(
              builder: (context, state) {
                if (state is LanguageCurrent) {
                  final currentIndex = state.index;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: languages.length,
                    itemBuilder: (context, index) {
                      final lang = languages[index]['lang'] as String;
                      final locale = languages[index]['locale'] as Locale;
                      return GestureDetector(
                        onTap: () {
                          print("tapped");
                          context.setLocale(locale);
                          context
                              .read<LanguageCubit>()
                              .onSetCurrentLanguage(index);
                        },
                        child: LanguageTile(
                          media: media,
                          language: lang,
                          isSelected: currentIndex == index,
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          )),
    );
  }
}
