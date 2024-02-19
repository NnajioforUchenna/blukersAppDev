import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/common_views/web_views/tap_to_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyPolicyTermsAndConditions extends StatelessWidget {
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  PrivacyPolicyTermsAndConditions({
    this.textColor = const Color.fromRGBO(189, 189, 189, 1),
    this.fontSize = 20,
    this.fontWeight = FontWeight.w900,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showPrivacyDialog(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeColors.grey2ThemeColor,
      ),
      child: Text(
        AppLocalizations.of(context)!.privacyAndTerms,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(
          //   textAlign: TextAlign.center,
          //   "Privacy and Terms",
          // ),
          content: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TapToWebView(
                  url: 'https://blukers.com/app-privacy-policy',
                  text: AppLocalizations.of(context)!.privacyPolicy,
                  textColor: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  appBarTitle: AppLocalizations.of(context)!.privacyPolicy,
                ),
                const SizedBox(height: 5),
                TapToWebView(
                  url: 'https://blukers.com/app-terms-of-service',
                  text: AppLocalizations.of(context)!.termsOfService,
                  textColor: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  appBarTitle: AppLocalizations.of(context)!.termsOfService,
                ),
                const SizedBox(height: 5),
                TapToWebView(
                  url: 'https://www.blukers.com/app-eula/',
                  text: 'EULA',
                  textColor: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  appBarTitle: 'EULA',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                color: ThemeColors.blukersBlueThemeColor,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
