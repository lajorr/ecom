import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/auth/presentation/screens/login_screen.dart';
import 'package:ecom/features/catalog/presentation/blocs/like%20bloc/like_bloc.dart';
import 'package:ecom/features/chat/presentation/blocs/cubit/show_send_button_cubit.dart';
import 'package:ecom/features/chat/presentation/screens/all_chats_screen.dart';
import 'package:ecom/features/chat/presentation/screens/chat_screen.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/presentation/blocs/cubit/credit_card_set_cubit.dart';
import 'package:ecom/features/checkout/presentation/screens/cart_history_screen.dart';
import 'package:ecom/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:ecom/features/map/presentation/screens/show_map_screen.dart';
import 'package:ecom/features/navbar/presentation/cubit/nav_index_cubit.dart';
import 'package:ecom/features/navbar/presentation/screens/navigation_menu.dart';
import 'package:ecom/features/prod_detail/presentation/screens/details_screen.dart';
import 'package:ecom/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:ecom/features/splash/presentation/splash_screen.dart';
import 'package:ecom/injection_container.dart';
import 'package:ecom/shared/validation/bloc/validation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteManager {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case NavigationMenu.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => NavIndexCubit(),
            child: const NavigationMenu(),
          ),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
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
              product: (settings.arguments! as Map<String, dynamic>)['product'],
              currentUser:
                  (settings.arguments! as Map<String, dynamic>)['currentUser'],
            ),
          ),
        );

      case CheckoutScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CreditCardSetCubit(),
            child: const CheckoutScreen(),
          ),
        );

      case CartHistoryScreen.routeName:
        return MaterialPageRoute(
          builder: (context) =>
              CartHistoryScreen(cart: settings.arguments! as CartModel),
        );

      case ShowMapScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => ShowMapScreen(
            onConfirmPosition:
                (settings.arguments! as Map<String, dynamic>)['onConfirmPos'],
          ),
        );
      case ChatScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<ShowSendButtonCubit>(),
            child: ChatScreen(
              otherUser: (settings.arguments!
                  as Map<String, dynamic>)['other_user'] as UserModel,
              currentUserId: (settings.arguments!
                  as Map<String, dynamic>)['current_user_id'] as String,
            ),
          ),
        );
      case AllChatsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const AllChatsScreen(),
        );
      case EditProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
      default:
        return null;
    }
  }
}
