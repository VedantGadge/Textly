import 'package:Textly/api/apis.dart';
import 'package:Textly/models/message.dart';
import 'package:flutter/material.dart';

class MesssageCard extends StatefulWidget {
  const MesssageCard({super.key, required this.message});
  final Message message;

  @override
  State<MesssageCard> createState() => _MesssageCardState();
}

class _MesssageCardState extends State<MesssageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
        ? _recieverMessage()
        : _senderMessage();
  }

  //reciever or our user message
  Widget _recieverMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.04),

            //double tick icon for msg read
            Icon(Icons.done_all_rounded,
                color: Colors.lightBlueAccent.shade200, size: 20),

            const SizedBox(width: 4),

            //read time
            Text(widget.message.sent,
                style: TextStyle(color: Colors.white30, fontSize: 13)),
          ],
        ),

        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff0288D1),
                  width: 2,
                ),
                color: Color(0xff4DD0E1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Text(
              widget.message.msg,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //sender or another user message message
  Widget _senderMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          //Flexible used to handle very long msg , so it would wrap
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff37474F),
                  width: 2,
                ),
                color: Color(0xff1C1F26),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
            child: Text(
              widget.message.msg,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04),
          child: Text(
            widget.message.sent,
            style: TextStyle(
              color: Colors.white24,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
