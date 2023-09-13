import 'package:flutter/material.dart';

class AuthInput extends StatelessWidget {
  AuthInput({
    super.key,
    required this.child,
  });

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(66, 129, 129, 129),
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(
              0.0,
              2.0,
            ), // shadow direction: bottom right
          )
        ],
      ),
      child: child,
    );
  }
}
