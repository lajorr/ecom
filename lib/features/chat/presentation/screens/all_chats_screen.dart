// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:ecom/features/chat/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/img_uri.dart';
import '../../../auth/data/model/user_model.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  static const routeName = '/all-chats';

  final UserModel currentUser;

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(FetchChatRoomsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Chats'),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatRoomLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChatRoomFailed) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ChatRoomLoaded) {
            final userList = state.userList;
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                final user = userList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(ChatScreen.routeName, arguments: {
                      'other_user': user,
                      'current_user': widget.currentUser,
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(100, 0, 0, 0),
                          blurRadius: 3,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(children: [
                      // pp
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: (user.imageUrl != null)
                                ? CachedNetworkImage(
                                    imageUrl: user.imageUrl!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.red,
                                        highlightColor: Colors.yellow,
                                        child: Container(
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Image.asset(
                                    ImageConstants.getImageUri(
                                        ImageConstants.profilePic),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  )),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        user.name!,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ]),
                  ),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
