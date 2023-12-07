import 'package:ecom/features/auth/presentation/login_screen.dart';
import 'package:ecom/features/auth/presentation/widget_tree.dart';
import 'package:ecom/features/checkout/presentation/checkout_screen.dart';
import 'package:ecom/features/prod_detail/presentation/details_screen.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      WidgetTree.routeName: (context) => const WidgetTree(),
      LoginScreen.routeName: (context) => const LoginScreen(),
      DetailsScreen.routeNmae: (context) => const DetailsScreen(),
      CheckoutScreen.routeName: (context) => const CheckoutScreen(),
    };
  }
}
