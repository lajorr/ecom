import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/common/widgets/my_shimmer.dart';
import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/img_uri.dart';
import '../blocs/chat bloc/chat_bloc.dart';
import '../widgets/chat_room_shimmer.dart';
import 'chat_screen.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/all-chats';

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
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Chats'),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatRoomLoading) {
            return ChatRoomShimmer(media: media);
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
                      'current_user_id': FireAuth().getCurrentUserId(),
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
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
                        height: media.height * 0.06,
                        width: media.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: (user.imageUrl != null)
                                ? CachedNetworkImage(
                                    imageUrl: user.imageUrl!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: MyShimmer(
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
