// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../providers/industry_provider.dart';
//
// class ShowSuggestions extends StatelessWidget {
//   const ShowSuggestions({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
//
//     return ip.predictions.isEmpty
//         ? Container()
//         : Column(
//             children: [
//               const SizedBox(
//                 height: 50,
//               ),
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: ip.predictions.length,
//                 itemBuilder: (context, index) {
//                   final prediction = ip.predictions[index];
//                   return ListTile(
//                     title: Text(prediction.fullText),
//                     onTap: () {
//                       ip.selectedPrediction(prediction);
//                     },
//                   );
//                 },
//               ),
//             ],
//           );
//   }
// }
