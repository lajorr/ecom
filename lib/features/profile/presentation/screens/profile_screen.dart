import 'package:ecom/features/chat/presentation/screens/all_chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/string_constants.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../../auth/presentation/widgets/my_text_field.dart';
import '../../../checkout/presentation/widgets/order_history.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/log_out_dialog.dart';
import '../widgets/profile_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();

  String? email;
  String? username;
  String? phNumber;
  String? imageUrl;

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter a Value';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Builder(
        builder: (context) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignoutSuccess) {
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(StringConstants.signoutSuccessText),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
              if (state is ProfileLoaded) {
                final currentUser = state.currentUser;
                email = currentUser.email;
                username = currentUser.name;
                phNumber = currentUser.phNumber.toString();
                imageUrl = currentUser.imageUrl;
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(username ?? "___"),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => BlocProvider.value(
                                value: context.read<ProfileBloc>(),
                                child: AlertDialog(
                                  content: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        MyTextField(
                                          initValue: username,
                                          label: "Username",
                                          prefixIcon: const Icon(Icons.person),
                                          inputType: TextInputType.name,
                                          onFieldSave: (value) {
                                            username = value;
                                          },
                                          validator: validator,
                                        ),
                                        MyTextField(
                                          initValue: phNumber,
                                          label: "Phone Number",
                                          prefixIcon: const Icon(Icons.phone),
                                          inputType: TextInputType.phone,
                                          onFieldSave: (value) {
                                            phNumber = value;
                                          },
                                          validator: validator,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    Builder(builder: (context) {
                                      return MaterialButton(
                                        onPressed: () {
                                          formKey.currentState!.save();
                                          if (formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<ProfileBloc>(
                                                    context)
                                                .add(
                                              UpdateUserDataEvent(
                                                username: username,
                                                phNumber: phNumber,
                                              ),
                                            );

                                            Navigator.of(context).pop();
                                          }
                                        },
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        child: const Text('Ok'),
                                      );
                                    }),
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      child: const Text('Cancel'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    actions: [
                      IconButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (ctx) => LogOutDialog(
                              media: media,
                              ctx: context,
                            ),
                          );
                        },
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ProfileImage(imageUrl: imageUrl),
                            const SizedBox(
                              height: 50,
                            ),
                            Text(email ?? ""),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(phNumber ?? "___"),
                            const SizedBox(
                              height: 25,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    AllChatsScreen.routeName,
                                    arguments: {'current_user': currentUser});
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor),
                              child: const Text(
                                'Chats',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Builder(builder: (context) {
                              return const OrderHistory();
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else if (state is ProfileLoading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Container();
              }
            }),
          );
        },
      ),
    );
  }
}
