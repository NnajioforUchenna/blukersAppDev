import 'package:blukers/utils/styles/theme_colors.dart';
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
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.2),
      //       spreadRadius: 2,
      //       blurRadius: 10,
      //       offset: Offset(0, 5),
      //     ),
      //   ],
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
                child: Icon(
              //building icon if no image
              Icons.apartment,
              size: size,
              color: ThemeColors.blukersOrangeThemeColor,
            )); // Or any placeholder widget
          },
        ),
      ),
    );
  }
}
