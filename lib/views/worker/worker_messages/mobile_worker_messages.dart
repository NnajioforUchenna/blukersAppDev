import 'package:flutter/material.dart';

class MobileWorkerMessages extends StatelessWidget {
  const MobileWorkerMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 400,
          color: Colors.purple,
        ),
        Container(
          height: 400,
          color: Colors.green,
        ),
      ],
    );
  }
}
