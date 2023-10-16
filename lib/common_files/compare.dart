// @override
// Widget build(BuildContext context) {
//   double width = MediaQuery.of(context).size.width;
//   double height = MediaQuery.of(context).size.height;
//   return Dialog(
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.all(Radius.circular(5)),
//     ),
//     insetPadding:
//     const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 80),
//     child: Stack(
//       alignment: Alignment.topCenter,
//       children: <Widget>[
//         Container(
//           width: double.infinity,
//           margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.05),
//           child: Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(
//                     top: height * 0.05, bottom: height * 0.06),
//                 child: Text(
//                   'References',
//                   style: GoogleFonts.montserrat(
//                       fontWeight: FontWeight.bold, fontSize: 24),
//                 ),
//               ),
//               Spacer(),
//               Container(
//                 height: height * 0.03,
//                 width: width * 0.23,
//                 margin: EdgeInsets.only(top: height * 0.03, bottom: 30.0),
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     elevation: 5,
//                     backgroundColor: ThemeColors.secondaryThemeColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                   ),
//                   child: Text(
//                     'Update',
//                     style: GoogleFonts.montserrat(
//                       color: Colors.white,
//                       fontSize: 12.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const Positioned(
//           top: 10, // Adjust as needed
//           left: 10, // Adjust as needed
//           child: SmallPopButtonWidget(),
//         ),
//       ],
//     ),
//   );
// }
