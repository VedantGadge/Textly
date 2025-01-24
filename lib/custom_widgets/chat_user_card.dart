import 'package:Textly/api/apis.dart';
import 'package:Textly/helper/my_time.dart';
import 'package:Textly/models/chat_user.dart';
import 'package:Textly/models/message.dart';
import 'package:Textly/screens/chat.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  //last message  info (if null --> no message)
  Message? _message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chat card with custom shape for seamless look
        Card(
          margin: EdgeInsets.zero, // Remove padding around the card
          color: const Color(0xff121212),
          elevation: 0,
          child: InkWell(
              onTap: () {
                //for navigating to chat screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChatScreen(
                              user: widget.user,
                            )));
              },
              child: StreamBuilder(
                stream: APIs.getLastMsg(widget.user),
                builder: (context, snapshot) {
                  final data = snapshot.data?.docs;
                  final list = data
                          ?.map((e) => Message.fromJson(e
                              .data())) //smilar to for() maps each data to each list element
                          .toList() ??
                      [];
                  if (list.isNotEmpty) _message = list[0];

                  return ListTile(
                      // Profile picture
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * 0.3),
                        child: CachedNetworkImage(
                          height: MediaQuery.of(context).size.height * 0.065,
                          width: MediaQuery.of(context).size.height * 0.065,
                          imageUrl: widget.user.image,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(CupertinoIcons.person_alt_circle),
                        ),
                      ),

                      // Name and last message
                      title: Text(
                        widget.user.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        _message != null ? _message!.msg : widget.user.about,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),

                      // Time and unread indicator
                      trailing: _message == null
                          ? null
                          : _message!.read.isEmpty &&
                                  _message!.fromId != APIs.user.uid
                              ? Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.greenAccent.shade400,
                                      borderRadius: BorderRadius.circular(10)),
                                )
                              : Text(MyTime.getLastMessageTime(
                                  context: context, time: _message!.sent)));
                },
              )),
        ),

        // Divider
        const Divider(
          color: Colors.white60,
          thickness: 0.1,
          height: 0,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
