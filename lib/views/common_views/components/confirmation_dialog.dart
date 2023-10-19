import 'package:flutter/material.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/data_providers/app_versions_data_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:unicons/unicons.dart';

import 'package:flutter/material.dart';

void confirmationDialog({
  required BuildContext context,
  required Function onConfirm,
  String title = "Title",
  String text = "Are you sure you want to proceed?",
  String cancelText = "Cancel",
  String confirmText = "Confirm",
  String stringsTemplate = "",
}) {
  if (stringsTemplate == "logout") {
    title = AppLocalizations.of(context)!.logout;
    text = AppLocalizations.of(context)!.areYouSureYouWantToLogOut;
    cancelText = AppLocalizations.of(context)!.cancel;
    confirmText = AppLocalizations.of(context)!.yes;
  }

  if (stringsTemplate == "deleteAccount") {
    title = AppLocalizations.of(context)!.deleteAccount;
    text = AppLocalizations.of(context)!.areYouSureYouWantToDeleteYourAccount;
    cancelText = AppLocalizations.of(context)!.cancel;
    confirmText = AppLocalizations.of(context)!.delete;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        actionsAlignment: MainAxisAlignment.center,
        title: Text(
          title,
          style: const TextStyle(
            color: ThemeColors.blukersBlueThemeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          text,
          style: const TextStyle(color: ThemeColors.grey1ThemeColor),
        ),
        actions: <Widget>[
          // TextButton(
          //   onPressed: () {
          //     // Close the dialog
          //     Navigator.of(context).pop();
          //   },
          //   child: Text(cancelText.toUpperCase()),
          // ),
          // TextButton(
          //   onPressed: () {
          //     // Perform the action by calling the onConfirm callback
          //     onConfirm();
          //     // Close the dialog
          //     Navigator.of(context).pop();
          //   },
          //   child: Text(confirmText.toUpperCase()),
          // ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: const Color.fromARGB(255, 205, 205, 205),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                child: Text(confirmText.toUpperCase()),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: ThemeColors.blukersOrangeThemeColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                child: Text(cancelText.toUpperCase()),
              ),
            ],
          ),
        ],
      );
    },
  );
}
