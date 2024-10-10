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
          title: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color(0xff5cf9b0),
                Color(0xff5ff2ed),
              ],
              tileMode: TileMode
                  .mirror, // Gradient behavior when extending beyond the bounds
            ).createShader(bounds),
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Textly',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          leading: const Icon(
            CupertinoIcons.home,
            color: Colors.black87,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.black87),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, color: Colors.black87),
            )
          ],
        ),

        //flolating action button to add new chat
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color(0xff5ff2ed),
            shape: const CircleBorder(),
            child: const Icon(Icons.add_comment_rounded, color: Colors.white),
          ),
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.width * .015),
          itemBuilder: (context, index) {
            return const ChatUserCard();
          },
          itemCount: 12,
        ),
        backgroundColor: const Color(0xff5ff2ed),
      ),
    );
  }
}
