import 'package:ecom/features/navbar/presentation/navigation_menu.dart';
import 'package:ecom/features/splash/presentation/splash_screen.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:ecom/shared/validation/bloc/validation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/catalog/presentation/blocs/like bloc/like_bloc.dart';
import '../../features/checkout/presentation/bloc/checkout_bloc.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/prod_detail/presentation/details_screen.dart';
import '../../injection_container.dart';

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
          builder: (context) => MultiBlocProvider(
              providers: [
                  BlocProvider(
                      create: (context) => sl<LikeBloc>(),
          
                    ),
                  BlocProvider(
                      create: (context) => CheckoutBloc(),
                  ),
              ],
                          child: DetailsScreen(
                        product: settings.arguments as ProductModel,
                      ),
          ),
        );

      case CheckoutScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CheckoutBloc(),
            child: const CheckoutScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
