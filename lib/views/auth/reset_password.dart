import '../../providers/user_provider_parts/user_provider.dart';
import '../../services/responsive.dart';
import '../../utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../common_vieiws/policy_terms/policy_terms_components/my_app_bar.dart';
import 'common_widget/submit_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

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
