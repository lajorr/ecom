import 'package:ecom/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecom/features/auth/presentation/screens/login_screen.dart';
import 'package:ecom/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecom/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/custom_appbar.dart';
import '../../../../constants/string_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // User currentUser = FireAuth().currentUser!;

    // String email = currentUser.email!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProfileBloc>()..add(FetchUserDataEvent()),
        ),
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
      ],
      child: Builder(builder: (context) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SignoutSuccess) {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(StringConstants.signoutSuccessText),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) => Scaffold(
              body: Builder(
                builder: (context) {
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const CustomAppbar(
                            title: StringConstants.profileText,
                            actions: false,
                            backButton: false,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          if (state is ProfileLoaded) Text(state.email),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(SignOutEvent());
                            },
                            child: const Text(
                              StringConstants.logOutText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        );
      }),
    );
  }
}
