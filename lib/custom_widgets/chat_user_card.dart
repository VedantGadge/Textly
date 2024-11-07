import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final String name;
  final String lastMessage;
  final String time;
  final bool isUnread;

  const ChatUserCard({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.isUnread = false,
  });

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
                widget.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                widget.lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              // Time and unread indicator
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.time,
                    style: TextStyle(
                      color: widget.isUnread ? Colors.blue : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  if (widget.isUnread)
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(
                        Icons.circle,
                        color: Colors.blue,
                        size: 10,
                      ),
                    ),
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
          indent: 35,
          endIndent: 35,
        ),
      ],
    );
  }
}
