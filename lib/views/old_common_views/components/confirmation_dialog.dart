import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/styles/index.dart';

void confirmationDialog({
  required BuildContext context,
  required Function onConfirm,
  String title = "Title",
  String text = "Are you sure you want to proceed?",
  String cancelText = "Cancel",
  String confirmText = "Confirm",
  String stringsTemplate = "",
}) {
  Color bgColor = ThemeColors.blukersOrangeThemeColor;
  if (stringsTemplate == "logout") {
    title = AppLocalizations.of(context)!.logout;
    text = AppLocalizations.of(context)!.areYouSureYouWantToLogOut;
    cancelText = AppLocalizations.of(context)!.cancel;
    confirmText = AppLocalizations.of(context)!.logout;
    bgColor = ThemeColors.blukersBlueThemeColor;
  }

  if (stringsTemplate == "deleteAccount") {
    title = AppLocalizations.of(context)!.deleteAccount;
    text = AppLocalizations.of(context)!.areYouSureYouWantToDeleteYourAccount;
    cancelText = AppLocalizations.of(context)!.cancel;
    confirmText = AppLocalizations.of(context)!.delete;
    bgColor = const Color(0xFFBC0101);
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        actionsAlignment: MainAxisAlignment.center,
        title: Center(
          child: Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: Responsive.isMobile(context) ? 16 : 28,
              color: bgColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        content: Text(text,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: Responsive.isMobile(context) ? 10 : 16,
              color: stringsTemplate == "deleteAccount"
                  ? const Color(0xFFC3AEAE)
                  : ThemeColors.grey1ThemeColor,
              fontWeight: FontWeight.w500,
            )),
        actions: <Widget>[
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(Responsive.isMobile(context) ? 110 : 180,
                      Responsive.isMobile(context) ? 42 : 50),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: bgColor,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                child: Text(
                  confirmText,
                  style: GoogleFonts.montserrat(
                    fontSize: Responsive.isMobile(context) ? 12 : 18,
                    fontWeight: FontWeight.w600,
                    color: bgColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(Responsive.isMobile(context) ? 110 : 180,
                      Responsive.isMobile(context) ? 42 : 50),
                  backgroundColor: stringsTemplate == "logout"
                      ? bgColor
                      : ThemeColors.blukersOrangeThemeColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                child: Text(
                  cancelText,
                  style: GoogleFonts.montserrat(
                      fontSize: Responsive.isMobile(context) ? 12 : 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      );
    },
  );
}
