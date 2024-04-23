import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/styles/index.dart';

class UpdateAppDialog extends StatelessWidget {
  const UpdateAppDialog({
    super.key,
    required this.url,
  });
  final String url;

  @override
  Widget build(BuildContext context) {
    String updateRequiredDescriptionText =
        AppLocalizations.of(context)!.updateRequiredDescription;
    return WillPopScope(
      onWillPop: () async =>
          false, // Prevent dialog from being closed using back button
      child: AlertDialog(
        // backgroundColor: ThemeColors.blukersBlueThemeColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        actionsAlignment: MainAxisAlignment.center,
        title: Text(
          AppLocalizations.of(context)!.updateRequired,
          style: const TextStyle(
            color: ThemeColors.blukersBlueThemeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                updateRequiredDescriptionText,
                style: const TextStyle(color: ThemeColors.grey1ThemeColor),
              ),
              const Icon(
                UniconsLine.sync,
                // UniconsLine.constructor,
                // UniconsLine.android,
                // UniconsLine.android_alt,
                // UniconsLine.apple,
                // UniconsLine.apple_alt,
                size: 50,
                color: ThemeColors.grey2ThemeColor,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              // You can add actions here when the user presses the update button
              // For example, launch the app store or exit the app
              print("url: $url");
              if (url != "") {
                launchUrl(
                  Uri.parse(url),
                  mode: LaunchMode.externalApplication,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.blukersOrangeThemeColor,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
            ),
            child: Text(AppLocalizations.of(context)!.update),
          ),
        ],
      ),
    );
  }
  //
}
