import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:flutter/material.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({super.key});

  static const routeName = '/all-chats';

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  @override
  void initState() {
    super.initState();
    FireCollections().getUserChatRooms();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Chats'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
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
            child: const Row(children: [
              CircleAvatar(
                radius: 28,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'USER NAME',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
