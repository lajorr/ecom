import 'package:ecom/features/checkout/presentation/blocs/orders%20bloc/orders_bloc.dart';
import 'package:ecom/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:ecom/features/map/presentation/bloc/map_bloc.dart';
import 'package:ecom/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/route_manager/route_manager.dart';
import 'common/theme_manager/theme_manager.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';
import 'features/checkout/presentation/blocs/checkoutbloc/checkout_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CheckoutBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PaymentBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<FavoritesBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<MapBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<OrdersBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ChatBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'E-com app',
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.getThemeData(),
        onGenerateRoute: routeManager.onGenerateRoute,
      ),
    );
  }
}
