import 'package:flutter/material.dart';

class PleaseCreateCompanyProfileMobile extends StatelessWidget {
  const PleaseCreateCompanyProfileMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Customize for mobile view
    return Scaffold(
      appBar: AppBar(title: const Text("Create Company Profile")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/company_profile_mobile.png'), // Example image
          const SizedBox(height: 20),
          const Text(
            'Please create a company profile to proceed.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
