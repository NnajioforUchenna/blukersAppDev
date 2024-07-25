import 'package:blukers/views/auth/login/components/sign_in_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';

class SignInOptions extends StatefulWidget {
  const SignInOptions({
    super.key,
  });

  @override
  State<SignInOptions> createState() => _SignInOptionsState();
}

class _SignInOptionsState extends State<SignInOptions> {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SignInOptionsWidget(
          icon: FontAwesomeIcons.google,
          onPressed: () {
            up.signInWithGoogle(context);
          },
          color: Colors.red,
        ),
        const SizedBox(width: 10),
        SignInOptionsWidget(
          icon: FontAwesomeIcons.facebook,
          onPressed: () {
            up.signInWithFacebook(context);
          },
          color: Colors.blue,
        ),
        const SizedBox(width: 10),
        // SignInOptionsWidget(
        //   icon: FontAwesomeIcons.apple,
        //   onPressed: () {
        //     up.signInWithApple(context);
        //   },
        //   color: Colors.grey.shade800,
        // ),
      ],
    );
  }
}
