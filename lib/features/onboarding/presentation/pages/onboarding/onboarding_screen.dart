import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State createState() => _OnboardingScreen();
}

class _OnboardingScreen extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Text("sth")));
  }
}
