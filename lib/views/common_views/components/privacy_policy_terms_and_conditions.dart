import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:blukers/views/common_views/components/my_app_bar.dart';
import 'package:blukers/views/common_views/components/loading_animation.dart';
import 'package:blukers/views/common_views/web_views/tap_to_web_view.dart';

class PrivacyPolicyTermsAndConditions extends StatelessWidget {
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  PrivacyPolicyTermsAndConditions({
    this.textColor = const Color.fromRGBO(189, 189, 189, 1),
    this.fontSize = 16,
    this.fontWeight = FontWeight.w900,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
