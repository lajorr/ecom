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

  final List<String> languages = [
    "english",
    "japanese",
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
                      final lang = languages[index];
                      return GestureDetector(
                        onTap: () {
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
