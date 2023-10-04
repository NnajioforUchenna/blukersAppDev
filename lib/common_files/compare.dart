// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'active_indicator_widget.dart';
// import 'diagonal_shape.dart';
//
// class NewMobileMembershipCard extends StatelessWidget {
//   final Color color;
//   final String title;
//   final String subtitle;
//   final double amount;
//   const NewMobileMembershipCard(
//       {super.key,
//       required this.color,
//       required this.title,
//       required this.amount,
//       required this.subtitle});
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width * 0.95;
//
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
//       elevation: 5.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       color: color,
//       child: Container(
//         height: height * 0.14,
//         width: width,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ActiveIndicatorWidget(isActive: false),
//             Spacer(),
//             Row(
//               children: [
//                 Expanded(
//                     flex: 3,
//                     child: DiagonalShape(
//                       height: height * 0.09,
//                     )),
//                 Expanded(flex: 2, child: Container()),
//                 Expanded(
//                     flex: 4,
//                     child: Transform.translate(
//                       offset: Offset(0, -20.0),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             title.toUpperCase(),
//                             style: GoogleFonts.montserrat(
//                               fontSize: 28.0,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           const Spacer(),
//                           Container(
//                             margin: const EdgeInsets.only(right: 20.0),
//                             child: const Icon(
//                               Icons.arrow_forward_ios,
//                               color: Colors.white,
//                             ),
//                           )
//                         ],
//                       ),
//                     )),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
