import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/common/widgets/profile_pic_widget.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecom/features/auth/presentation/screens/login_screen.dart';
import 'package:ecom/features/checkout/presentation/widgets/order_history.dart';
import 'package:ecom/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final media = MediaQuery.of(context).size;
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
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileLoaded) {
          final currentUser = state.currentUser;
          email = currentUser.email;
          username = currentUser.name;
          phNumber = currentUser.phNumber.toString();
          imageUrl = currentUser.imageUrl;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Center(
                        child: ProfilePicWidget(
                      imageUrl: currentUser.imageUrl,
                      size: 0.12,
                    ),),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(username ?? '___'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(email ?? ''),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(phNumber ?? '___'),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: media.height * 0.05,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        StringConstants.orderHistoryText.tr(),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const OrderHistory(),
                  ],
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
      },),
    );
  }
}
