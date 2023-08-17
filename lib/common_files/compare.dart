// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class SplashScreenCustomShape extends StatelessWidget {
//   final double width;
//   final double height;
//
//   SplashScreenCustomShape({this.width = 400, this.height = 700});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CustomPaint(
//         painter: MyCustomPainter(width, height),
//         child: Container(
//           width: width,
//           height: height,
//         ),
//       ),
//     );
//   }
// }
//
// class MyCustomPainter extends CustomPainter {
//   final double width;
//   final double height;
//
//   MyCustomPainter(this.width, this.height);
//
//   Path createRoundedRectPath(double x, double y) {
//     final double rectWidth = width * 0.5;
//     final double rectHeight = height * 0.0625;
//     final double borderRadius =
//         20; // you can adjust this value relative to width and height
//
//     return Path()
//       ..moveTo(x + borderRadius, y)
//       ..lineTo(x + rectWidth - borderRadius, y)
//       ..quadraticBezierTo(x + rectWidth, y, x + rectWidth, y + borderRadius)
//       ..lineTo(x + rectWidth, y + rectHeight - borderRadius)
//       ..quadraticBezierTo(x + rectWidth, y + rectHeight,
//           x + rectWidth - borderRadius, y + rectHeight)
//       ..lineTo(x + borderRadius, y + rectHeight)
//       ..quadraticBezierTo(x, y + rectHeight, x, y + rectHeight - borderRadius)
//       ..lineTo(x, y + borderRadius)
//       ..quadraticBezierTo(x, y, x + borderRadius, y)
//       ..close();
//   }
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint bluePaint = Paint()..color = const Color(0xFF1c75bb);
//     final Paint orangePaint = Paint()..color = Color(0xFFf06523);
//     final double borderRadius =
//         40; // you can adjust this value relative to width and height
//
//     // Draw the blue upper part
//     Path bluePath = Path()
//       ..moveTo(0, borderRadius)
//       ..quadraticBezierTo(0, 0, borderRadius, 0)
//       ..lineTo(width - borderRadius, 0)
//       ..quadraticBezierTo(width, 0, width, borderRadius)
//       ..lineTo(width, height * 0.25)
//       ..lineTo(0, height * 0.75)
//       ..close();
//     canvas.drawPath(bluePath, bluePaint);
//
//     // Draw the orange lower part
//     Path orangePath = Path()
//       ..moveTo(0, height - borderRadius)
//       ..quadraticBezierTo(0, height, borderRadius, height)
//       ..lineTo(width - borderRadius, height)
//       ..quadraticBezierTo(width, height, width, height - borderRadius)
//       ..lineTo(width, height * 0.3125)
//       ..lineTo(0, height * 0.8125)
//       ..lineTo(0, borderRadius)
//       ..close();
//     canvas.drawPath(orangePath, orangePaint);
//
//     Path workerBg = createRoundedRectPath(width * 0.375, height * 0.4125);
//     canvas.drawPath(workerBg, bluePaint);
//
//     Path companyBg = createRoundedRectPath(width * 0.15, height * 0.575);
//     canvas.drawPath(companyBg, orangePaint);
//
//     // Adding worker and company text
//
//     // Centered "Worker" text
//     final TextPainter workerTextPainter = TextPainter(
//       text: TextSpan(
//           text: 'Worker',
//           style: GoogleFonts.montserrat(
//             color: Colors.white,
//             fontWeight: FontWeight.w700,
//             fontSize: 30,
//             shadows: <Shadow>[
//               Shadow(
//                 offset: Offset(1.0, 1.0),
//                 blurRadius: 10.0,
//                 color: Colors.black.withOpacity(0.7),
//               ),
//             ],
//           )),
//       textDirection: TextDirection.ltr,
//     );
//     workerTextPainter.layout();
//     final Offset workerTextOffset = Offset(
//       width * 0.4 + (width * 0.5 - workerTextPainter.width) / 2,
//       height * 0.4125 + (height * 0.0625 - workerTextPainter.height) / 2,
//     );
//     workerTextPainter.paint(canvas, workerTextOffset);
//
//     // Centered "Company" text
//     final TextPainter companyTextPainter = TextPainter(
//       text: TextSpan(
//           text: 'Company',
//           style: GoogleFonts.montserrat(
//             color: Colors.white,
//             fontWeight: FontWeight.w700,
//             fontSize: 30,
//             shadows: <Shadow>[
//               Shadow(
//                 offset: Offset(1.0, 1.0),
//                 blurRadius: 8.0,
//                 color: Colors.black.withOpacity(0.5),
//               ),
//             ],
//           )),
//       textDirection: TextDirection.ltr,
//     );
//     companyTextPainter.layout();
//     final Offset companyTextOffset = Offset(
//       width * 0.12 + (width * 0.5 - companyTextPainter.width) / 2,
//       height * 0.570 + (height * 0.0625 - companyTextPainter.height) / 2,
//     );
//     companyTextPainter.paint(canvas, companyTextOffset);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
