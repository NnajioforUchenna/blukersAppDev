import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'common_widget/company_logo.dart';
import 'common_widget/login_or_register.dart';

class PleaseLogin extends StatelessWidget {
  const PleaseLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginOrRegister();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Company Logo
          const CompanyLogo(),
          const SizedBox(height: 30.0),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                const TextSpan(text: 'Please '),
                TextSpan(
                    text: 'Login',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigate to login page or perform login action here

                        context.go('/login');
                      }),
                const TextSpan(text: ' or '),
                TextSpan(
                    text: 'Register',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigate to register page or perform register action here

                        context.go('/register');
                      }),
                const TextSpan(text: ' to perform this action.'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
