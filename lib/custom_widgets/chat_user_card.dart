import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .04, vertical: 4),
      child: InkWell(
        onTap: () {},
        child: const ListTile(
          //user profile pic
          leading: CircleAvatar(
              child: Icon(
            CupertinoIcons.person,
          )),

          //user name
          title: Text(
            'Demo User',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),

          //last message
          subtitle: Text(
            'Last user message',
            maxLines: 1,
            style: TextStyle(color: Colors.black54),
          ),

          //last message time
          trailing: Text(
            '10:54 AM',
            maxLines: 1,
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
