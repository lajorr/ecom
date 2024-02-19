import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../auth/presentation/bloc/auth_bloc.dart';
import '../../auth/presentation/screens/login_screen.dart';
import '../../navbar/presentation/screens/navigation_menu.dart';
import '../../profile/presentation/bloc/profile_bloc.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<AuthBloc>(context).add(CheckUserExistsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        Future.delayed(
          const Duration(seconds: 5),
          () {
            if (state is UserAvailable) {
              BlocProvider.of<ProfileBloc>(context).add(FetchUserDataEvent());
              Navigator.of(context)
                  .pushReplacementNamed(NavigationMenu.routeName);
            } else if (state is UserUnavailable) {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            } else if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Lottie.network(
              'https://lottie.host/b16d8847-a93f-467f-89bb-9cde5e2fb97a/3NcQfnAQYe.json',
              height: media.height * 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
