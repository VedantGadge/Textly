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
            child: const Text(
              'Textly',
              style: TextStyle(fontSize: 30),
            ),
          ),
          leading: const Icon(
            CupertinoIcons.home,
            color: Color(0xff5ff2ed),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Color(0xff5ff2ed)),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, color: Color(0xff5ff2ed)),
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
