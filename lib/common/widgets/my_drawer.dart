// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecom/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:ecom/shared/theme%20cubit/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/chat/presentation/screens/all_chats_screen.dart';
import '../../features/profile/presentation/widgets/log_out_dialog.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
    required this.ctx,
  }) : super(key: key);

  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Drawer(
      child: BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text(
                      StringConstants.editProfileText,
                    ).tr(),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushNamed(EditProfileScreen.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.chat),
                    title: const Text(
                      StringConstants.chatText,
                    ).tr(),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AllChatsScreen.routeName,
                      );
                    },
                  ),
                  const ThemeChangeWidget(),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text(
                      StringConstants.languageText,
                    ).tr(),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ChangeLanguageDialog(
                          media: media,
                        ),
                      );
                    },
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text(StringConstants.logoutText).tr(),
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: ctx,
                    builder: (context) => LogOutDialog(
                      media: media,
                      ctx: ctx,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChangeLanguageDialog extends StatelessWidget {
  const ChangeLanguageDialog({
    Key? key,
    required this.media,
  }) : super(key: key);

  final Size media;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LanguageTile(media: media),
            LanguageTile(media: media),
            LanguageTile(media: media),
          ],
        ),
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.media,
  });

  final Size media;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Row(
        children: [
          SizedBox(
            height: media.height * 0.05,
            width: media.height * 0.05,
            child: const Center(
              child: Icon(Icons.done),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Text("English"),
        ],
      ),
    );
  }
}

class ThemeChangeWidget extends StatefulWidget {
  const ThemeChangeWidget({
    super.key,
  });

  @override
  State<ThemeChangeWidget> createState() => _ThemeChangeWidgetState();
}

class _ThemeChangeWidgetState extends State<ThemeChangeWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDark = false;
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        if (state is ThemeModeDark) {
          isDark = state.isDark;
        } else if (state is ThemeModeLight) {
          isDark = state.isDark;
        }
        return ListTile(
          leading: const Icon(Icons.light_mode),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(StringConstants.darkModeText).tr(),
              Switch(
                value: isDark,
                onChanged: (value) {
                  setState(() {
                    isDark = !isDark;
                  });
                  context.read<ThemeCubit>().toggleTheme(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
