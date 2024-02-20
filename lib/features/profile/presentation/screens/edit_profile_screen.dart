import 'package:ecom/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../auth/presentation/widgets/my_text_field.dart';
import '../widgets/profile_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const routeName = '/edit-profile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  String? name;
  String? phNumber;

  void onConfirmEdit() {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(
            UpdateUserDataEvent(
              username: name,
              phNumber: phNumber,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
        ),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoaded) {
              final user = state.currentUser;
              setState(() {
                name = user.name;
                phNumber = user.phNumber.toString();
              });
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: LottieBuilder.network(
                    'https://lottie.host/9ae8ec07-82fc-4db9-af4c-1ae669cb294e/y4012cjn1O.json'),
              );
            } else if (state is ProfileLoaded) {
              final user = state.currentUser;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Center(
                          child: ProfileImage(
                            imageUrl: user.imageUrl,
                          ),
                        ),
                        SizedBox(
                          height: media.height * 0.05,
                        ),
                        MyTextField(
                          initValue: user.name,
                          label: 'Username',
                          prefixIcon: const Icon(Icons.person),
                          onFieldSave: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          validator: (str) {
                            if (str == null || str.isEmpty) {
                              return "Please enter a username";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: media.height * 0.02,
                        ),
                        MyTextField(
                          initValue: user.phNumber.toString(),
                          label: 'Phone',
                          prefixIcon: const Icon(Icons.phone),
                          onFieldSave: (value) {
                            setState(() {
                              phNumber = value;
                            });
                          },
                          inputType: TextInputType.number,
                          validator: (str) {
                            if (str == null || str.isEmpty) {
                              return "Please enter a phoneNumber";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: media.height * 0.08,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: onConfirmEdit,
                          color: Theme.of(context).primaryColor,
                          child: const Text(
                            'Update',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
