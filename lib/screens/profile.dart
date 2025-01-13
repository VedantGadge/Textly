import 'package:Textly/api/apis.dart';
import 'package:Textly/custom_widgets/chat_user_card.dart';
import 'package:Textly/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ChatUser> Userslist = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //AppBar
        appBar: AppBar(
          backgroundColor: const Color(0xff121212),
          title: const Text(
            "Textly",
            style: TextStyle(color: Color(0xff9C27B0)),
          ),
          leading: const Icon(
            CupertinoIcons.home,
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, color: Colors.white),
            )
          ],
          elevation: 0,
        ),

        //flolating action button to add new chat
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            onPressed: () async {
              await APIs.auth.signOut();
              await GoogleSignIn().signOut();
            },
            backgroundColor: const Color(0xff4DD0E1),
            shape: const CircleBorder(),
            child: const Icon(Icons.add_comment_rounded, color: Colors.white),
          ),
        ),

        //body
        body: StreamBuilder(
            stream: APIs.firestore.collection('users').snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                //if data is loading (waiting or none)
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());

                //if data is done loading(even partly)
                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;
                  Userslist = data
                          ?.map((e) => ChatUser.fromJson(e
                              .data())) //smilar to for() maps each data to each list element
                          .toList() ??
                      [];
                  if (Userslist.isNotEmpty) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * .015),
                      itemBuilder: (context, index) {
                        return ChatUserCard(
                          user: Userslist[index],
                        );
                      },
                      itemCount: Userslist.length,
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No Connections Found !',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    );
                  }
              }
            }),
        backgroundColor: const Color(0xff121212),
      ),
    );
  }
}
