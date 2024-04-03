import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/auth/presentation/widgets/login_card.dart';
import 'package:ecom/injection_container.dart';
import 'package:ecom/shared/validation/bloc/validation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = './login-screen';

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Builder(builder: (context) {
        return SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: media.width * 0.6,
                    child: const Text(
                      StringConstants.welcomeMsg,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 42,
                      ),
                    ).tr(),
                  ),
                  SizedBox(
                    height: media.height * 0.1,
                  ),
                  BlocProvider(
                    create: (context) => ValidationBloc(
                      textValidator: sl(),
                    ),
                    child: const LoginCard(),
                  ),
                ],
              ),
            ),
          ),
        );
      },),
    );
  }
}
