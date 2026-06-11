import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Text("explore")));
  }
}
