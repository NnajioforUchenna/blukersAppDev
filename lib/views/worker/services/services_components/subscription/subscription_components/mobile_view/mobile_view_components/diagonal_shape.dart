import 'package:flutter/material.dart';

class DiagonalShape extends StatelessWidget {
  final double height;
  final double width;
  const DiagonalShape({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5.0, left: 5.0),
      width: width,
      height: height,
      child: CustomPaint(
        painter: _DiagonalCutPainter(),
      ),
    );
  }
}

class _DiagonalCutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0) // Upper left corner
      ..lineTo(0, size.height) // Upper right corner
      ..lineTo(size.width, size.height) // Lower right corner
      ..close();

    final roundedRectanglePath = Path()
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0, 0, // Top-left point
          size.width, size.height, // Bottom-right point
          topLeft: Radius.zero, // No rounding for top-left
          topRight: Radius.zero, // No rounding for top-right
          bottomLeft: const Radius.circular(15), // Rounded bottom-left
          bottomRight: Radius.zero, // Rounded bottom-right
        ),
      );

    final cutPath =
        Path.combine(PathOperation.intersect, roundedRectanglePath, path);

    canvas.drawPath(cutPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
