import 'package:Textly/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
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
            onTap: () {},
            child: ListTile(
              // Profile picture
              leading: const CircleAvatar(
                radius: 25,
                child: Icon(
                  CupertinoIcons.person_alt_circle,
                  color: Colors.black,
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
                widget.user.about,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              // Time and unread indicator
              trailing: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('12:00 PM'),
                ],
              ),
            ),
          ),
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
