import 'package:easy_localization/easy_localization.dart';

import 'package:ecom/features/language/presentation/widgets/language_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/string_constants.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/chat/presentation/screens/all_chats_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/widgets/log_out_dialog.dart';
import '../../theme/presentation/theme cubit/cubit/theme_cubit.dart';


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
                  ListTile(
                    leading: const Icon(Icons.light_mode),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(StringConstants.darkModeText).tr(),
                        BlocBuilder<ThemeCubit, ThemeState>(
                          builder: (context, state) {
                            final statee = state as ThemeStatus;
                            return Switch(
                              value: statee.isDark,
                              onChanged: (value) {
                                context.read<ThemeCubit>().toggleTheme(value);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text(
                      StringConstants.languageText,
                    ).tr(),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ChangeLanguageDialog(
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

// class ThemeChangeWidget extends StatelessWidget {
//   ThemeChangeWidget({
//     super.key,
//   });
//   var z = false;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: const Icon(Icons.light_mode),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(StringConstants.darkModeText).tr(),
//           BlocBuilder<ThemeCubit, ThemeState>(
//             builder: (context, state) {
//               final statee = state as ThemeStatus;
//               return Switch(
//                 value: statee.isDark,
//                 onChanged: (value) {
//                   context.read<ThemeCubit>().toggleTheme(value);
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
