import 'package:flutter/material.dart';

class Passwordtoggle extends StatelessWidget {
  final bool showPassword;
  final VoidCallback onToggle;

  const Passwordtoggle({
    super.key,
    required this.showPassword,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
    );
  }
}
