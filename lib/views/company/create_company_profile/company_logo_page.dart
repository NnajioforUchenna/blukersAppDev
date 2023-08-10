import 'package:bulkers/providers/company_provider.dart';
import 'package:bulkers/utils/styles/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../services/responsive.dart';
import 'your_company_logo.dart';

class CompanyLogoPage extends StatefulWidget {
  CompanyLogoPage({Key? key}) : super(key: key);

  @override
  _CompanyLogoPageState createState() => _CompanyLogoPageState();
}

class _CompanyLogoPageState extends State<CompanyLogoPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    CompanyProvider cp = Provider.of<CompanyProvider>(context);

    return SizedBox(
      height: height * 0.7,
      child: Center(
        child: Container(
          width: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Upload Company Logo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const YourCompanyLogo(), // Replace with your widget to handle company logo
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          if (cp.appUser?.photoUrl != null) {
                            // Update the condition to check for company logo
                            cp.companyProfileNextPage();
                          }
                          ;
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ThemeColors.secondaryThemeColor),
                        ),
                        child: const Text("Next"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
