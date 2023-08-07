import 'package:flutter/material.dart';

class RoundedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double size;

  const RoundedImageWidget(
      {super.key, required this.imageUrl, this.size = 50.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.2), // Adjust opacity for a more prominent shadow
            spreadRadius: 2, // Increase spread for a more noticeable elevation
            blurRadius: 10, // Increase blur for a softer shadow
            offset: Offset(0,
                5), // Increase vertical offset to enhance the elevation effect
          ),
        ],
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
