// import 'dart:html' as html;
// import 'dart:ui_web' as ui;
//
// import 'package:flutter/material.dart';
//
// class ProcessStripePayment extends StatefulWidget {
//   const ProcessStripePayment({Key? key}) : super(key: key);
//
//   @override
//   State<ProcessStripePayment> createState() => _ProcessStripePaymentState();
// }
//
// class _ProcessStripePaymentState extends State<ProcessStripePayment> {
//   @override
//   void initState() {
//     // Register the view factory.
//     ui.platformViewRegistry.registerViewFactory(
//       'stripe-elements-view',
//           (int viewId) => _createIframeElement(),
//     );
//
//     html.window.onMessage.listen((html.MessageEvent event) {
//       if (event.data == "Payment successful") {
//         // Handle the successful payment in your Flutter web app
//       }
//     });
//
//     super.initState();
//   }
//
//   html.IFrameElement _createIframeElement() {
//     final iframe = html.IFrameElement()
//       ..width = '100%'
//       ..height = '100%'
//       ..src = 'web/stripe_payment/stripe-elements.html'
//       ..style.border = 'none';
//     return iframe;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.topCenter,
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: const HtmlElementView(viewType: 'stripe-elements-view'),
//         ),
//         Row(
//           children: [
//             const Spacer(),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: FloatingActionButton(
//                 child: const Icon(Icons.close),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
