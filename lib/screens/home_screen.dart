import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../widgets/category_selector.dart';
import '../widgets/favorite_contacts.dart';
import '../widgets/recent_chats.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchPressed = false;
  var _controller = TextEditingController();

  _searchField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        autofocus: true,
        controller: _controller,
        textCapitalization: TextCapitalization.sentences,
        onChanged: (value) {},
        decoration: InputDecoration.collapsed(hintText: 'Send a message...'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        searchPressed = false;
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.menu),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () {}),
            title: !searchPressed
                ? Text(
                    'Chats',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : _searchField(),
            elevation: 0.0,
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  iconSize: 30.0,
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      searchPressed = !searchPressed;
                    });
                  }),
            ],
          ),
          body: Column(
            children: [
              CategorySelector(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  height: 500,
                  child: Column(
                    children: [FavoriteContacts(), RecentChats()],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
