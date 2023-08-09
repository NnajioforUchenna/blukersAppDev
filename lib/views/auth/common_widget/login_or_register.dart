import 'package:bulkers/views/auth/common_widget/company_logo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class LoginOrRegister extends StatelessWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Company Logo
          const CompanyLogo(),
          const SizedBox(height: 15.0),

          Icon(
            UniconsLine.user,
            color: Colors.grey.shade400,
            size: 60,
          ),
          const SizedBox(height: 10.0),

          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18.0,
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
                        print('Login clicked');
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (Route<dynamic> route) => false);
                      }),
                const TextSpan(text: ' or '),
                TextSpan(
                    text: 'Register',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigate to register page or perform register action here
                        print('Register clicked');
                        Navigator.pushNamedAndRemoveUntil(context, '/register',
                            (Route<dynamic> route) => false);
                      }),
                const TextSpan(text: ' to display this details.'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
