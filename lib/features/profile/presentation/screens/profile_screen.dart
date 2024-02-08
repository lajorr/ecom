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

  @override
  Widget build(BuildContext context) {
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
                final user = state.currentUser;
                email = user.email;
                username = user.name;
                phNumber = user.phNumber.toString();
                imageUrl = user.imageUrl;
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
                                          label: "Username",
                                          prefixIcon: const Icon(Icons.person),
                                          inputType: TextInputType.name,
                                          onFieldSave: (value) {
                                            username = value;
                                          },
                                        ),
                                        MyTextField(
                                          label: "Phone Number",
                                          prefixIcon: const Icon(Icons.phone),
                                          inputType: TextInputType.phone,
                                          onFieldSave: (value) {
                                            phNumber = value;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    Builder(builder: (context) {
                                      return MaterialButton(
                                        onPressed: () {
                                          formKey.currentState!.save();

                                          BlocProvider.of<ProfileBloc>(context)
                                              .add(
                                            UpdateUserDataEvent(
                                              username: username,
                                              phNumber: phNumber,
                                            ),
                                          );

                                          Navigator.of(context).pop();
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
                          BlocProvider.of<AuthBloc>(context)
                              .add(SignOutEvent());
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
                                Navigator.of(context)
                                    .pushNamed(AllChatsScreen.routeName);
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
