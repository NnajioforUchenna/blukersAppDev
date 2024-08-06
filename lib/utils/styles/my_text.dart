import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final Widget child;
  const MyText({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: child,
    );
  }
}
