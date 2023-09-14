import 'package:flutter/material.dart';

class ApplicantCount extends StatelessWidget {
  final int count;

  final Color color; // Change type from Colors to Color
  const ApplicantCount({Key? key, required this.count, required this.color})
      : super(key: key); // Add Key? for the key parameter

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color, // Remove the const modifier
        ),
        alignment: Alignment.center,
        child: Text(
          count.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
