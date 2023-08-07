import 'package:flutter/material.dart';

class BlurOut extends StatelessWidget {
  final bool isBlur;
  final Widget child;

  const BlurOut({Key? key, required this.isBlur, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return isBlur ? const Text(" ************ ") : child;
  }
}
