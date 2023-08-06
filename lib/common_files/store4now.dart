// import 'package:flutter/material.dart';
//
// class Store4Now extends StatelessWidget {
//   const Store4Now({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return         Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         side: const BorderSide(
//             color: ThemeColors.primaryThemeColor, width: 2),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       margin: const EdgeInsets.symmetric(
//           vertical: 10, horizontal: 0), // Adjust for spacing
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 10,
//           horizontal: 15,
//         ),
//         onTap: () {
//           if (Responsive.isDesktop(context)) {
//             wp.setSelectedWorker(worker);
//             //
//           } else {
//             showDialog(
//                 context: context,
//                 builder: (context) => DisplayWorkerDialog(
//                   worker: worker,
//                 ));
//           }
//           //
//         },
//         title: Text(
//           '${worker.firstName} ${worker.lastName}',
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: ThemeColors.primaryThemeColor,
//           ),
//         ),
//         subtitle: Text(worker.skillIds.toString()),
//         leading: Container(
//           width: 50,
//           height: 50,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(100),
//             image: DecorationImage(
//               image: NetworkImage(worker.profilePhotoUrl!),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         trailing: Row(
//           mainAxisSize:
//           MainAxisSize.min, // Take up only as much space as needed
//           children: [
//             IconButton(
//               onPressed: () async {
//                 // Add functionality for Save
//                 if (up.appUser == null) {
//                   showDialog(
//                       context: context,
//                       builder: (context) => PleaseLoginDialog());
//                 } else {
//                   bool? result = await showDialog<bool>(
//                     context: context,
//                     builder: (context) => ConfirmationDialog(
//                       worker: worker,
//                     ),
//                   );
//                   if (result != null && result) {
//                     wp.addInterestingWorker(up.appUser, worker);
//                   }
//                 }
//                 ;
//               },
//               icon:
//               Icon(Icons.bookmark), // Assuming this is the 'Save' icon
//             ),
//             IconButton(
//               onPressed: () async {
//                 // Add functionality for Chat
//                 String roomId = await chatProvider.createChatRoom(
//                     myUid: up.appUser!.uid,
//                     recipientUid: worker.workerId,
//                     myName: up.appUser!.displayName ?? "Company",
//                     recipientName: worker.firstName + worker.lastName,
//                     message: "",
//                     myLogo: up.appUser!.photoUrl ?? "",
//                     recipientLogo: worker.profilePhotoUrl ?? "");
//                 chatProvider.activeRoomId = roomId;
//                 Navigator.pushNamed(context, '/chat-message', arguments: {
//                   "roomId": roomId,
//                   "roomName": worker.firstName + worker.lastName,
//                 });
//               },
//               icon: Icon(Icons.chat), // Chat icon
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
