import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/route_manager/route_manager.dart';
import 'common/theme_manager/theme_manager.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/catalog/presentation/blocs/catalog%20bloc/catalog_bloc.dart';
import 'features/chat/presentation/blocs/chat bloc/chat_bloc.dart';
import 'features/checkout/presentation/blocs/checkoutbloc/checkout_bloc.dart';
import 'features/checkout/presentation/blocs/cubit/credit_card_set_cubit.dart';
import 'features/checkout/presentation/blocs/orders%20bloc/orders_bloc.dart';
import 'features/favorites/presentation/bloc/favorites_bloc.dart';
import 'features/map/presentation/bloc/map_bloc.dart';
import 'features/payment/presentation/bloc/payment_bloc.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'theme/presentation/theme cubit/cubit/theme_cubit.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  di.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ja', 'JPN'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ja', 'JPN'),
      child: const MyApp(),
    ),
  );
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
        ),
        BlocProvider(
          create: (context) => sl<CreditCardSetCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<CatalogBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ThemeCubit>(),
        ),
      ],
      child: Builder(builder: (context) {
        context.read<ThemeCubit>().getThemeStatus();
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            if (state is ThemeStatus) {
              return MaterialApp(
                title: 'Q-cart',
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                theme: state.isDark
                    ? ThemeManager.getDarkThemeData()
                    : ThemeManager.getLightThemeData(),
                onGenerateRoute: routeManager.onGenerateRoute,
              );
            } else {
              return Container();
            }
          },
        );
      }),
    );
  }
}
