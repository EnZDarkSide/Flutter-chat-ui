import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Widget _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
        width: MediaQuery.of(context).size.width * 0.75,
        margin: isMe
            ? EdgeInsets.only(top: 8, bottom: 8, left: 80.0)
            : EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
            color: isMe ? Theme.of(context).accentColor : Color(0xFFEFEFEE),
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.time,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
            SizedBox(
              height: 8,
            ),
            Text(message.text,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ],
        ));
    if (isMe) {
      return msg;
    }
    return Row(
      children: [
        msg,
        IconButton(
            icon: message.isLiked
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            iconSize: 40.0,
            color: message.isLiked
                ? Theme.of(context).primaryColor
                : Colors.blueGrey,
            onPressed: () {
              setState(() {
                message.isLiked = !message.isLiked;
              });
            }),
      ],
    );
  }

  var _controller = TextEditingController();

  _buildMessageComposer() {
    var tf = TextField(
      controller: _controller,
      onSubmitted: (value) => (_sendMsg()),
      textCapitalization: TextCapitalization.sentences,
      onChanged: (value) {},
      decoration: InputDecoration.collapsed(hintText: 'Send a message...'),
    );

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: 70,
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.photo),
                iconSize: 25,
                color: Theme.of(context).primaryColor,
                onPressed: () {}),
            Expanded(child: tf),
            IconButton(
                icon: Icon(Icons.send),
                iconSize: 25,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _sendMsg();
                })
          ],
        ));
  }

  void _sendMsg() {
    if (_controller.text.length == 0) return;

    final now = new DateTime.now();
    String time = DateFormat('jm').format(now);

    var newMsg = new Message();
    newMsg.text = _controller.text;
    newMsg.sender = currentUser;
    newMsg.time = time;
    newMsg.isLiked = false;

    setState(() {
      chats.insert(0, newMsg);
      messages.insert(0, newMsg);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          widget.user.name,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.more_horiz),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {}),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.only(top: 15),
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        Message message = messages[index];
                        final bool isMe = message.sender.id == currentUser.id;
                        return _buildMessage(message, isMe);
                      }),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
