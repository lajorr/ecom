import 'package:ecom/screens/navigation_menu.dart';
import 'package:ecom/services/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      builder: (context, child) => MaterialApp(
        title: 'E-com app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xff292526),
          useMaterial3: true,
          hintColor: const Color(0xff878787),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            bodySmall: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        home: const NavigationMenu(),
      ),
    );
  }
}
