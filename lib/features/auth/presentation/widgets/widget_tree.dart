import '../../../../core/firebaseFunctions/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../../../navbar/presentation/navigation_menu.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  static const routeName = '/widget-tree';

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FireAuth().authStateChanges,
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
