import 'package:blukers/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common_widget/submit_button.dart';

import 'package:blukers/views/common_views/components/index.dart';

import 'package:blukers/services/responsive.dart';
import 'package:blukers/utils/styles/index.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emailController = TextEditingController();

  isFormComplete() {
    return emailController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.resetPassword,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CompanyLogo(),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.resetPasswordDescription,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.grey1ThemeColor,
                ),
              ),
              const SizedBox(height: 50),
              _buildEmailField(),
              const SizedBox(height: 50),
              _buildResetButton(context, up),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.email,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: (value) {
        setState(() {
          isFormComplete();
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.pleaseEnterYourEmail;
        }
        // You can add additional email validation logic here if needed
        return null;
      },
      // Handle email input
      // onChanged: (value) {
      //   // Store the email value in a variable or state if needed
      // },
    );
  }

  Widget _buildResetButton(context, up) {
    return SubmitButton(
        isDisabled: !isFormComplete(),
        onTap: () {
          if (isFormComplete()) {
            up.resetPassword(context, emailController.text);
          }
        },
        text: AppLocalizations.of(context)!.resetPassword);
  }
}
