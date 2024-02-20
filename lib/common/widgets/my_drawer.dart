// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecom/features/profile/presentation/screens/edit_profile_screen.dart';
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
                    title: const Text('Edit Profile'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushNamed(EditProfileScreen.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.chat),
                    title: const Text('Chats'),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AllChatsScreen.routeName,
                      );
                    },
                  ),
                  const ListTile(
                    leading: Icon(Icons.toggle_off),
                    title: Text('Light'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.language),
                    title: Text('Language'),
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
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
