import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common_widget/company_logo.dart';
import 'common_widget/submit_button.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            _buildResetButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
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

  Widget _buildResetButton() {
    return SubmitButton(onTap: onResetPassword, text: "Reset Password");
  }

  onResetPassword() {
    print("Reset button tapped");
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );
  }
}
