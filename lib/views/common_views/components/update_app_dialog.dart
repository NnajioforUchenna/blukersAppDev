import 'package:flutter/material.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/data_providers/app_versions_data_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateAppDialog extends StatelessWidget {
  const UpdateAppDialog({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          false, // Prevent dialog from being closed using back button
      child: AlertDialog(
        title: Text(AppLocalizations.of(context)!.updateRequired),
        content: Text(AppLocalizations.of(context)!.updateRequiredDescription),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              // You can add actions here when the user presses the update button
              // For example, launch the app store or exit the app
              print("url: " + url);
              if (url != "") {
                launchUrl(
                  Uri.parse(url),
                  mode: LaunchMode.externalApplication,
                );
              }
            },
            child: Text(AppLocalizations.of(context)!.update),
          ),
        ],
      ),
    );
  }
  //
}
