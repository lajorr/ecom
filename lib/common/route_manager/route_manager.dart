import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/widgets/widget_tree.dart';
import '../../features/checkout/presentation/checkout_screen.dart';
import '../../features/prod_detail/presentation/details_screen.dart';
import '../../injection_container.dart';

class RouteManager {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      WidgetTree.routeName: (context) => const WidgetTree(),
      LoginScreen.routeName: (context) => const LoginScreen(),
      DetailsScreen.routeNmae: (context) => const DetailsScreen(),
      CheckoutScreen.routeName: (context) => const CheckoutScreen(),
    };
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthBloc(
              // textValidator: sl(),
              loginUsecase: sl(),
              signupUsecase: sl(),
              googleSigninUsecase: sl(),
            ),
            child: const WidgetTree(),
          ),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case DetailsScreen.routeNmae:
        return MaterialPageRoute(
          builder: (context) => const DetailsScreen(),
        );
      case CheckoutScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const CheckoutScreen(),
        );
      default:
        return null;
    }
  }
}
