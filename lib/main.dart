import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/route_manager/route_manager.dart';
import 'common/theme_manager/theme_manager.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    RouteManager routeManager = RouteManager();
    return BlocProvider(
      create: (context) => sl<ProfileBloc>(),
      child: MaterialApp(
        title: 'E-com app',
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.getThemeData(),
        onGenerateRoute: routeManager.onGenerateRoute,
      ),
    );
  }
}
