// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecom/features/navbar/presentation/navigation_menu.dart';
import 'package:ecom/shared/validation/bloc/validation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/my_text_field.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final formKey = GlobalKey<FormState>();

  bool onSignUp = false;

  String email = '';
  String password = '';
  void onFormSave() {
    formKey.currentState!.save();

    BlocProvider.of<ValidationBloc>(context).add(
      ValidateInputEvent(email: email, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<ValidationBloc, ValidationState>(
        listener: (context, validationState) {
          if (validationState is ValidationSuccess) {
            if (!onSignUp) {
              BlocProvider.of<AuthBloc>(context).add(
                LoginEvent(
                  email: email,
                  password: password,
                ),
              );
            } else {
              BlocProvider.of<AuthBloc>(context).add(
                SignUpEvent(
                  email: email,
                  password: password,
                ),
              );
            }
          } else if (validationState is ValidationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.error,
                content: Text(validationState.message),
              ),
            );
          }
        },
        builder: (context, validationState) =>
            BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Text(state.message),
                ),
              );
            } else if (state is UserAvailable) {
              Navigator.of(context)
                  .pushReplacementNamed(NavigationMenu.routeName);
            }
          },
          builder: (context, state) {
            return LoadingWidet(
              isLoading: state is AuthLoading,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.8,
                padding: const EdgeInsets.all(22),
                margin: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          onSignUp
                              ? StringConstants.signupText
                              : StringConstants.loginText,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        MyTextField(
                          label: StringConstants.emailLabel,
                          errorMsg: (validationState is ValidationFailure)
                              ? validationState.message
                              : null,
                          prefixIcon: const Icon(
                            Icons.mail_outline_rounded,
                          ),
                          inputType: TextInputType.emailAddress,
                          onFieldSave: (value) {
                            email = value!;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          errorMsg: (validationState is ValidationFailure)
                              ? validationState.message
                              : null,
                          label: StringConstants.passwordLabel,
                          prefixIcon: const Icon(
                            Icons.vpn_key,
                          ),
                          inputType: TextInputType.visiblePassword,
                          obscure: true,
                          onFieldSave: (value) {
                            password = value!;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        // forgot? login btn
                        Row(
                          mainAxisAlignment: onSignUp
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            if (!onSignUp)
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  StringConstants.forgotPasswordText,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(120, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor: const Color(0xff292526),
                              ),
                              onPressed: onFormSave,
                              child: Text(
                                onSignUp
                                    ? StringConstants.signupText
                                    : StringConstants.loginText,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // login from google
                        Container(
                          height: 50,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // BlocProvider.of<AuthBloc>(context).si
                            },
                            child: const Text(
                              StringConstants.googleLoginText,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            setState(() {
                              onSignUp = !onSignUp;
                            });
                          },
                          child: Text(
                            onSignUp
                                ? StringConstants.haveAnAccountText
                                : StringConstants.noAccountText,
                            style: const TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class LoadingWidet extends StatelessWidget {
  const LoadingWidet({
    Key? key,
    required this.child,
    required this.isLoading,
  }) : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            height: MediaQuery.of(context).size.height / 2,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            color: const Color.fromARGB(77, 0, 0, 0),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
