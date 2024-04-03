import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/common/route_manager/route_manager.dart';
import 'package:ecom/common/theme_manager/theme_manager.dart';
import 'package:ecom/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecom/features/catalog/presentation/blocs/catalog%20bloc/catalog_bloc.dart';
import 'package:ecom/features/chat/presentation/blocs/chat%20bloc/chat_bloc.dart';
import 'package:ecom/features/checkout/presentation/blocs/checkoutbloc/checkout_bloc.dart';
import 'package:ecom/features/checkout/presentation/blocs/cubit/credit_card_set_cubit.dart';
import 'package:ecom/features/checkout/presentation/blocs/orders%20bloc/orders_bloc.dart';
import 'package:ecom/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:ecom/features/map/presentation/bloc/map_bloc.dart';
import 'package:ecom/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:ecom/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecom/firebase_options.dart';
import 'package:ecom/injection_container.dart' as di;
import 'package:ecom/injection_container.dart';
import 'package:ecom/theme/presentation/theme%20cubit/cubit/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final routeManager = RouteManager();
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
      },),
    );
  }
}
