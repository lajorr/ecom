import 'package:ecom/shared/validation/bloc/validation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/string_constants.dart';
import '../../../../injection_container.dart';
import '../widgets/login_card.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = './login-screen';

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade300,
      extendBody: true,
      body: Builder(builder: (context) {
        return SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    StringConstants.welcomeMsg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 42,
                    ),
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
      }),
    );
  }
}
