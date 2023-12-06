import 'package:ecom/screens/login_screen.dart';
import 'package:ecom/screens/navigation_menu.dart';
import 'package:ecom/services/auth.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const NavigationMenu();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
