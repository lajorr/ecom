import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/presentation/screens/cart_history_screen.dart';
import 'package:ecom/features/map/presentation/screens/show_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/catalog/presentation/blocs/like bloc/like_bloc.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/map/presentation/bloc/map_bloc.dart';
import '../../features/navbar/presentation/navigation_menu.dart';
import '../../features/prod_detail/presentation/screens/details_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../injection_container.dart';
import '../../shared/catalog/model/product_model.dart';
import '../../shared/validation/bloc/validation_bloc.dart';

class RouteManager {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<AuthBloc>(),
            child: const SpashScreen(),
          ),
        );
      case NavigationMenu.routeName:
        return MaterialPageRoute(
          builder: (context) => const NavigationMenu(),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<AuthBloc>(),
              ),
              BlocProvider(
                create: (context) => sl<ValidationBloc>(),
              ),
            ],
            child: const LoginScreen(),
          ),
        );
      case DetailsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<LikeBloc>(),
            child: DetailsScreen(
              product: settings.arguments as ProductModel,
            ),
          ),
        );

      case CheckoutScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const CheckoutScreen(),
        );

      case CartHistoryScreen.routeName:
        return MaterialPageRoute(
          builder: (context) =>
              CartHistoryScreen(cart: settings.arguments as CartModel),
        );

      case ShowMapScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<MapBloc>(),
            child: const ShowMapScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
