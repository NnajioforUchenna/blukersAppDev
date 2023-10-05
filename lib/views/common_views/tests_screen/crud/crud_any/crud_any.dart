// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:go_router/go_router.dart';
// import 'crud_create.dart';
// import 'crud_delete.dart';
// import 'crud_read_all.dart';
// import 'crud_read.dart';
// import 'crud_search.dart';
// import 'crud_update.dart';

// class CRUDAny extends StatefulWidget {
//   @override
//   _CRUDAnyState createState() => _CRUDAnyState();
// }

// class _CRUDAnyState extends State<CRUDAny> {
//   final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
//   bool productCreationSuccess = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('CRUDAny'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             buildButton(context, 'CRUD Create', CRUDCreate()),
//             const SizedBox(height: 10),
//             buildButton(context, 'CRUD Read All', CRUDReadAll()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildButton(
//     context,
//     text,
//     Widget widget,
//   ) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: const BoxDecoration(
//         color: Colors.green,
//       ),
//       child: TextButton(
//         // onPressed: () => context.push(),
//         onPressed: () => Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => widget)),
//         child: Text(
//           text,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }