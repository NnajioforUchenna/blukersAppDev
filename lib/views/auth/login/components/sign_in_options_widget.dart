import 'package:flutter/material.dart';

class SignInOptionsWidget extends StatelessWidget {
  const SignInOptionsWidget({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 24,
        color: color,
      ),
    );
  }
}
