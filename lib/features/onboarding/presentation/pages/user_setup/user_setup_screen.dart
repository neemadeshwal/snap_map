import 'package:flutter/material.dart';

class UserSetupScreen extends StatefulWidget {
  const UserSetupScreen({super.key});

  @override
  State createState() => _UserSetupScreen();
}

class _UserSetupScreen extends State<UserSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Text("user setup"))),
    );
  }
}
