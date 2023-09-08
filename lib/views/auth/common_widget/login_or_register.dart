import 'package:blukers/views/auth/common_widget/company_logo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginOrRegister extends StatelessWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Company Logo
            // const CompanyLogo(),
            // const SizedBox(height: 15.0),

            Icon(
              UniconsLine.user,
              color: Colors.grey.shade400,
              size: 100,
            ),
            const SizedBox(height: 10.0),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.grey1ThemeColor,
                ),
                children: <TextSpan>[
                  // const TextSpan(text: 'Please '),
                  TextSpan(text: AppLocalizations.of(context)!.please + ' '),
                  TextSpan(
                      text: AppLocalizations.of(context)!.login2,
                      style:
                          const TextStyle(color: ThemeColors.primaryThemeColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to login page or perform login action here
                          print('Login clicked');
                          Navigator.pushNamedAndRemoveUntil(context, '/login',
                              (Route<dynamic> route) => false);
                        }),
                  TextSpan(text: ' ' + AppLocalizations.of(context)!.or + ' '),
                  TextSpan(
                      text: AppLocalizations.of(context)!.register,
                      style:
                          const TextStyle(color: ThemeColors.primaryThemeColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to register page or perform register action here
                          print('Register clicked');
                          Navigator.pushNamedAndRemoveUntil(context,
                              '/register', (Route<dynamic> route) => false);
                        }),
                  const TextSpan(text: '\n'),
                  TextSpan(
                    text: AppLocalizations.of(context)!
                        .toContinueOrAccessThisContent,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
