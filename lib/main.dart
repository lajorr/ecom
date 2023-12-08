import 'package:ecom/common/route_manager/route_manager.dart';
import 'package:ecom/common/theme_manager/theme_manager.dart';
import 'package:ecom/features/auth/presentation/widget_tree.dart';
import 'package:ecom/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-com app',
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getThemeData(),
      home: const WidgetTree(),
      routes: RouteManager.getRoutes(),
    );
  }
}
