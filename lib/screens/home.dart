import 'dart:developer';

import 'package:Textly/api/apis.dart';
import 'package:Textly/custom_widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            onPressed: () {},
            backgroundColor: const Color(0xff4DD0E1),
            shape: const CircleBorder(),
            child: const Icon(Icons.add_comment_rounded, color: Colors.white),
          ),
        ),

        //body
        body: StreamBuilder(
            stream: APIs.firestore.collection('users').snapshots(),
            builder: (context, snapshot) {
              final Userslist = [];

              if (snapshot.hasData) {
                final data = snapshot.data?.docs;
                for (var i in data!) {
                  log('Data: ${i.data()}');
                  Userslist.add(i.data()['name']);
                }
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .015),
                itemBuilder: (context, index) {
                  return ChatUserCard(
                    name: Userslist[index],
                    lastMessage: 'Hello, wassup',
                    time: '10:24',
                  );
                },
                itemCount: Userslist.length,
              );
            }),
        backgroundColor: const Color(0xff121212),
      ),
    );
  }
}
