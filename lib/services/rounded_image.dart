import 'package:flutter/material.dart';

import '../common_files/constants.dart';
import 'alternative_logo_widget.dart';

class RoundedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double size;
  final String firstChar;

  const RoundedImageWidget({
    Key? key,
    required this.imageUrl,
    required this.firstChar,
    this.size = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: !isWellFormedUrl(imageUrl)
              ? AlternativeLogoWidget(
                  char: firstChar,
                  size: size,
                )
              : Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return AlternativeLogoWidget(
                      char: firstChar,
                      size: size,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
