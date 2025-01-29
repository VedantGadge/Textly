import 'package:Textly/api/apis.dart';
import 'package:Textly/helper/my_time.dart';
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
            if (widget.message.read.isNotEmpty)
              Icon(Icons.done_all_rounded,
                  color: Colors.lightBlueAccent.shade200, size: 15),

            const SizedBox(width: 4),

            //sent time
            Text(
                MyTime.getFormattedTime(
                    context: context, time: widget.message.sent),
                style: TextStyle(color: Colors.white30, fontSize: 12)),
          ],
        ),

        //message content
        Flexible(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 2.5, bottom: 2.5, left: 4, right: 4),
            child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .02),
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
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  widget.message.msg,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //sender or another user message message
  Widget _senderMessage() {
    //update last read message if sender and reciever are different
    if (widget.message.read.isEmpty) {
      APIs.updateMsgReadStatus(widget.message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          //Flexible used to handle very long msg , so it would wrap
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * .02),
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
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Text(
                widget.message.msg,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04),
          child: Text(
            MyTime.getFormattedTime(
                context: context, time: widget.message.sent),
            style: TextStyle(
              color: Colors.white24,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
