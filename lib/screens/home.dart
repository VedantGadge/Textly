import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //AppBar
        appBar: AppBar(
          title: const Text('Textly'),
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
        ),

        //flolating action button to add new chat
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color(0xff5ff2ed),
            shape: const CircleBorder(
                side: BorderSide(width: 1.5, color: Colors.white)),
            child: const Icon(Icons.add_comment_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
