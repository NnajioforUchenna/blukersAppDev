import 'package:bulkers/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'common_widget/company_logo.dart';
import 'common_widget/submit_button.dart';

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
      appBar: AppBar(
        title: Text("Reset Password",
            style: GoogleFonts.ebGaramond(
              color: Colors.deepOrangeAccent,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.25,
            )),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CompanyLogo(),
            const SizedBox(height: 20),
            const Text(
              "Enter the email address associated with your account. A link to reset your password will be sent to your email address.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 50),
            _buildEmailField(),
            const SizedBox(height: 50),
            _buildResetButton(context, up),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: "Email",
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
          return "Please enter your email";
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
        text: "Reset Password");
  }
}
