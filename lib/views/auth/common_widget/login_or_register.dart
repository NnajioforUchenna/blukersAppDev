import 'package:blukers/views/auth/login/login.dart';
import 'package:flutter/material.dart';


class LoginOrRegister extends StatelessWidget {
  const LoginOrRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return const Login();
    // Center(
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Icon(
    //           UniconsLine.user,
    //           color: Colors.grey.shade400,
    //           size: 100,
    //         ),
    //         const SizedBox(height: 10.0),
    //         RichText(
    //           textAlign: TextAlign.center,
    //           text: TextSpan(
    //             style: const TextStyle(
    //               fontFamily: 'Montserrat',
    //               fontSize: 20.0,
    //               fontWeight: FontWeight.bold,
    //               color: ThemeColors.grey1ThemeColor,
    //             ),
    //             children: <TextSpan>[
    //               // const TextSpan(text: 'Please '),
    //               TextSpan(text: '${AppLocalizations.of(context)!.please} '),
    //               TextSpan(
    //                   text: AppLocalizations.of(context)!.login2,
    //                   style:
    //                       const TextStyle(color: ThemeColors.primaryThemeColor),
    //                   recognizer: TapGestureRecognizer()
    //                     ..onTap = () {
    //                       // Navigate to login page or perform login action here
    //                       context.go('/login');
    //                     }),
    //               TextSpan(text: ' ${AppLocalizations.of(context)!.or} '),
    //               TextSpan(
    //                   text: AppLocalizations.of(context)!.register,
    //                   style:
    //                       const TextStyle(color: ThemeColors.primaryThemeColor),
    //                   recognizer: TapGestureRecognizer()
    //                     ..onTap = () {
    //                       // Navigate to register page or perform register action here
    //                       context.go('/register');
    //                     }),
    //               const TextSpan(text: '\n'),
    //               TextSpan(
    //                 text: AppLocalizations.of(context)!
    //                     .toContinueOrAccessThisContent,
    //               ),
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  
  }
}
