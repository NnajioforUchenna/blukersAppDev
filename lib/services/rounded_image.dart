import 'package:flutter/material.dart';

import '../common_files/constants.dart';
import '../views/common_vieiws/policy_terms/policy_terms_components/loading_animation.dart';
import 'alternative_logo_widget.dart';

class RoundedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double size;
  final String firstChar;

  const RoundedImageWidget({
    super.key,
    required this.imageUrl,
    required this.firstChar,
    this.size = 50.0,
  });

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
              offset: const Offset(0, 5),
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
                    return const Center(child: LoadingAnimation());
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
