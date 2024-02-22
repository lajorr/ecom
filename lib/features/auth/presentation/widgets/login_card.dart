// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecom/features/navbar/presentation/screens/navigation_menu.dart';
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
    final media = MediaQuery.of(context).size;
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
      builder: (context, validationState) => BlocConsumer<AuthBloc, AuthState>(
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
            media: media,
            isLoading: state is AuthLoading,
            child: Container(
              width: double.infinity,
              height: media.height * 0.5,
              padding: const EdgeInsets.all(22),
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
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
                      ).tr(),
                      MyTextField(
                        label: StringConstants.emailLabel,
                        hintText: "abc@gmail.com",
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
                        hintText: "xxxxxxxx",
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
                              ).tr(),
                            ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(120, 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            onPressed: onFormSave,
                            child: Text(
                              onSignUp
                                  ? StringConstants.signupText
                                  : StringConstants.loginText,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ).tr(),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: media.height * 0.01,
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
                        ).tr(),
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
  }
}

class LoadingWidet extends StatelessWidget {
  const LoadingWidet({
    Key? key,
    required this.child,
    required this.isLoading,
    required this.media,
  }) : super(key: key);

  final Widget child;
  final bool isLoading;
  final Size media;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            height: media.height * 0.5,
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
