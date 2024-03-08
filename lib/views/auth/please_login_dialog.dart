import 'package:flutter/material.dart';

import '../../utils/styles/index.dart';
import 'common_widget/login_or_register.dart';

class PleaseLoginDialog extends StatelessWidget {
  const PleaseLoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      child: IntrinsicHeight(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      backgroundColor: ThemeColors.blukersOrangeThemeColor,
                      child: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
              const LoginOrRegister(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
