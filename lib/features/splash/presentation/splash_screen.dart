import 'package:ecom/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecom/features/auth/presentation/screens/login_screen.dart';
import 'package:ecom/features/navbar/presentation/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        Future.delayed(
          const Duration(seconds: 3),
          () {
            if (state is UserAvailable) {
              Navigator.of(context)
                  .pushReplacementNamed(NavigationMenu.routeName);
            }
            else if (state is UserUnavailable)
            {
               Navigator.of(context)
                  .pushReplacementNamed(LoginScreen.routeName);
            }
          },
        );
      },
      child: const Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('Loading...'),
          ),
        ),
      ),
    );
  }
}
