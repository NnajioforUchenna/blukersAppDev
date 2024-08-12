import 'package:flutter/material.dart';

class BlurOut extends StatelessWidget {
  final bool isBlur;
  final Widget child;

  const BlurOut({super.key, required this.isBlur, required this.child});
  @override
  Widget build(BuildContext context) {
    return isBlur ? const Text(" ************ ") : child;
  }
}
