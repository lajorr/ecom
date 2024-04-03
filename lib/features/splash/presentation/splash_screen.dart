import 'package:ecom/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecom/features/auth/presentation/screens/login_screen.dart';
import 'package:ecom/features/navbar/presentation/screens/navigation_menu.dart';
import 'package:ecom/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
          const Duration(seconds: 3),
          () {
            if (state is UserAvailable) {
              BlocProvider.of<ProfileBloc>(context).add(FetchUserDataEvent());
              Navigator.of(context).pushReplacementNamed(
                NavigationMenu.routeName,
                arguments: {'user': state.user},
              );
            } else if (state is UserUnavailable) {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            } else if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            } else {}
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
