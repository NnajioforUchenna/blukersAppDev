import 'package:flutter/material.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/data_providers/app_versions_data_provider.dart';

// class UpdateAppDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map>(
//       future: AppVersionsDataProvider().shouldUpdateApp(),
//       builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // While waiting for the future to complete, you can return a loading indicator
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           // Handle error cases
//           return Text('Error: ${snapshot.error}');
//         } else if (snapshot.data?.containsKey('answer') == true &&
//             snapshot.data!['answer'] == true) {
//           // Return your update dialog here
//           return AlertDialog(
//             title: Text('Update App'),
//             content: Text('Please update the app to continue.'),
//             actions: <Widget>[
//               ElevatedButton(
//                 onPressed: () {
//                   // Add your update actions here
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//                 child: Text('Update'),
//               ),
//             ],
//           );
//         } else {
//           // Return your regular UI here
//           return Text('Your regular content');
//         }
//       },
//     );
//   }
// }

class UpdateAppDialog extends StatelessWidget {
  UpdateAppDialog({super.key});

  shouldUpdateApp() async {
    bool shouldShowUpdateDialog = false;
    Map shouldUpdateApp = await AppVersionsDataProvider().shouldUpdateApp();
    if (shouldUpdateApp.containsKey('answer') &&
        shouldUpdateApp['answer'] == true) {
      shouldShowUpdateDialog = true;
    }
    print('shouldShowUpdateDialog');
    print(shouldShowUpdateDialog);
    return shouldShowUpdateDialog;
  }

  @override
  Widget build(BuildContext context) {
    if (shouldUpdateApp()) {
      showDialog(
        context: context,
        barrierDismissible:
            false, // Dialog cannot be dismissed by tapping outside
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async =>
                false, // Prevent dialog from being closed using back button
            child: AlertDialog(
              title: Text('Update App'),
              content: Text('Please update the app to continue.'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // You can add actions here when the user presses the update button
                    // For example, launch the app store or exit the app
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          );
        },
      );
      return Container();
    } else {
      return Container();
    }
  }
  //
}
