import 'dart:convert';
import 'dart:developer';

import 'package:Textly/api/apis.dart';
import 'package:Textly/custom_widgets/messsage_card.dart';
import 'package:Textly/models/chat_user.dart';
import 'package:Textly/models/message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //for storing all messages
  List<Message> _list = [];

  //for handling message text chanegs
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff121212),
        appBar: AppBar(
          backgroundColor: const Color(0xff121212),
          automaticallyImplyLeading: false,
          flexibleSpace: _appBar(),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Divider(
                color: Colors.white60, // Border color
                thickness: 0.4, // Border thickness
                height: 0.4 // Ensures the height matches the thickness
                ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.2, // Adjust opacity for better readability
                child: Image.asset(
                  'assets/imgs/darkbg1.jpeg', // Replace with your asset path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: APIs.getAllMsgs(widget.user),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          //if data is loading (waiting or none)
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const SizedBox();

                          //if data is done loading(even partly)
                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;
                            _list = data
                                    ?.map((e) => Message.fromJson(e
                                        .data())) //smilar to for() maps each data to each list element
                                    .toList() ??
                                [];

                            if (_list.isNotEmpty) {
                              return ListView.builder(
                                  itemCount: _list.length,
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.width *
                                          .015),
                                  itemBuilder: (context, index) {
                                    return MesssageCard(
                                      message: _list[index],
                                    );
                                  });
                            } else {
                              return const Center(
                                child: Text(
                                  'Say Hii! 👋',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              );
                            }
                        }
                      }),
                ),
                _chatInput(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //app bar widget
  Widget _appBar() {
    return InkWell(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //back button
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white70,
            ),
          ),

          //adding some space
          SizedBox(width: 10),

          //user profile
          ClipRRect(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height * 0.03),
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height * .05,
                width: MediaQuery.of(context).size.height * .05,
                fit: BoxFit.cover,
                imageUrl: widget.user.image,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Icon(CupertinoIcons.person_alt_circle),
              )),

          //adding some space
          SizedBox(width: 13),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //user name
              Text(
                widget.user.name,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),

              //for adding some space
              SizedBox(height: 2),

              //last seen time of the user
              Text(
                'Last seen not available',
                style: TextStyle(color: Colors.white54, fontSize: 13),
              ),
            ],
          )
        ],
      ),
    );
  }

  //bottom chat user field
  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .01,
          horizontal: MediaQuery.of(context).size.width * .01),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Colors.white,
              child: Row(
                children: [
                  //Emoji button
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                      color: const Color(0xff4DD0E1),
                      size: 25,
                    ),
                  ),

                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    cursorColor: const Color(0xff4DD0E1),
                    decoration: InputDecoration(
                      hintText: 'Type something...',
                      hintStyle: TextStyle(color: Colors.black38),
                      border: InputBorder.none,
                    ),
                  )),

                  //Gallery button
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.image_outlined,
                      color: const Color(0xff4DD0E1),
                      size: 25,
                    ),
                  ),

                  //Camera button
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt_rounded,
                      color: const Color(0xff4DD0E1),
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //send message button
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                APIs.sendMessage(widget.user, _textController.text);
                _textController.text = '';
              }
            },
            minWidth: 0, // the button tkaes only the space neccesary
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
            shape: CircleBorder(),
            color: const Color(0xff4DD0E1),
            child: Icon(
              Icons.send_rounded,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
