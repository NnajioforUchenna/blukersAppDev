import 'package:flutter/material.dart';

class WebDiagonallyCutRoundedRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      child: CustomPaint(
        painter: _WebDiagonalCutPainter(),
      ),
    );
  }
}

class _WebDiagonalCutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(80, 0) // Upper left corner
      ..lineTo(size.width, 0) // Upper right corner
      ..lineTo(size.width, size.height) // Lower right corner
      ..close();

    final roundedRectanglePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
          Radius.circular(15),
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