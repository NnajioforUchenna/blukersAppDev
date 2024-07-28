import 'package:flutter/material.dart';

class GreyContainerText extends StatelessWidget {
  final Text child;
  const GreyContainerText({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey,
      ),
      child: child,
    );
  }
}
