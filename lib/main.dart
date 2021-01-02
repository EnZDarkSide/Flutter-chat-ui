import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Material Chat UI',
      theme:
          ThemeData(accentColor: Color(0xFFFEF9EB), primaryColor: Colors.red),
      home: HomeScreen(),
    );
  }
}
