import 'package:flutter/material.dart';

class RightCharacter extends StatelessWidget {
  final String imageUrl;
  const RightCharacter({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Positioned(
      right: 40,
      top: 160,
      child: Container(
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
