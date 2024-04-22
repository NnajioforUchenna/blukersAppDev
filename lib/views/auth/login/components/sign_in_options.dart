import 'package:blukers/views/auth/login/components/sign_in_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInOptions extends StatelessWidget {
  const SignInOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SignInOptionsWidget(
          icon: FontAwesomeIcons.google,
          onPressed: () {},
          color: Colors.red,
        ),
        const SizedBox(width: 10),
        SignInOptionsWidget(
          icon: FontAwesomeIcons.facebook,
          onPressed: () {},
          color: Colors.blue,
        ),
        const SizedBox(width: 10),
        SignInOptionsWidget(
          icon: FontAwesomeIcons.apple,
          onPressed: () {},
          color: Colors.grey.shade800,
        ),
      ],
    );
  }
}
