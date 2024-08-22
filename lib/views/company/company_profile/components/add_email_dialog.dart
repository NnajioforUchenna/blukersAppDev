// import 'package:blukers/views/company/comapny_profile/components/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../providers/user_provider_parts/user_provider.dart';
// import '../../../../utils/styles/theme_colors.dart';
// import '../../../old_common_views/small_pop_button_widget.dart';
//
// class AddDetails extends StatefulWidget {
//   const AddDetails({super.key});
//
//   @override
//   State<AddDetails> createState() => _AddDetailsState();
// }
//
// class _AddDetailsState extends State<AddDetails> {
//   TextEditingController emailController = TextEditingController();
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       UserProvider up = Provider.of<UserProvider>(context, listen: false);
//       if (up.appUser != null && up.appUser?.company != null) {
//         emailController.text = up.appUser?.company?.emails.first ?? '';
//       }
//     });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Dialog(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(5)),
//       ),
//       insetPadding:
//           const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 80),
//       child: Stack(
//         alignment: Alignment.topLeft,
//         children: <Widget>[
//           Container(
//             width: width * 0.8,
//             margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.05),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(
//                         top: height * 0.05, bottom: height * 0.06),
//                     child: Text(
//                       'Add Email',
//                       style: GoogleFonts.montserrat(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//                     child: TextInputWidget(
//                       label: 'Email',
//                       maxLines: 1,
//                       controller: emailController,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//           const Positioned(
//             top: 10, // Adjust as needed
//             left: 10,
//             child: SmallPopButtonWidget(),
//           ),
//         ],
//       ),
//     );
//   }
// }
