import 'package:blukers/views/common_views/please_login.dart';
import 'package:flutter/material.dart';
import '../auth/common_widget/login_or_register.dart';
import 'package:blukers/utils/styles/index.dart';

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
              LoginOrRegister(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
