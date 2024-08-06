// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class TextInputWidget extends StatelessWidget {
//   final String label;
//   final int maxLines;
//   final TextEditingController controller;
//
//   const TextInputWidget({
//     required this.label,
//     required this.maxLines,
//     required this.controller,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.montserrat(
//             fontWeight: FontWeight.w400,
//             fontSize: 12,
//           ),
//         ),
//         const SizedBox(height: 5),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 controller: controller,
//                 maxLines: maxLines,
//                 decoration: InputDecoration(
//                   filled: true,
//                   isDense: true,
//                   contentPadding: const EdgeInsets.symmetric(
//                       vertical: 7.0, horizontal: 10.0),
//                   fillColor: Colors.grey[200],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
