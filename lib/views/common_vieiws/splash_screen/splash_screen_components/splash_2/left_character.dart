import 'package:flutter/material.dart';

class LeftCharacter extends StatelessWidget {
  final String imageUrl;
  const LeftCharacter({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Positioned(
      left: 60,
      bottom: 100,
      child: SizedBox(
        height: height * 0.28,
        width: width * 0.32,
        child: Image.asset(
          imageUrl, // Replace with your asset name
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
