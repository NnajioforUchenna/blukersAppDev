import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/company_provider.dart';
import '../../../services/responsive.dart';
import '../../worker/create_worker_profile/create_worker_profile_components/timeline_navigation_button.dart';
import 'your_company_logo.dart';

class CompanyLogoPage extends StatefulWidget {
  const CompanyLogoPage({super.key});

  @override
  _CompanyLogoPageState createState() => _CompanyLogoPageState();
}

class _CompanyLogoPageState extends State<CompanyLogoPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    CompanyProvider cp = Provider.of<CompanyProvider>(context);

    return SizedBox(
      height: height * 0.6,
      child: Center(
        child: Container(
          color: Colors.white,
          width: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Text(
              //   AppLocalizations.of(context)!.uploadCompanyLogo,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.deepOrangeAccent,
              //     fontSize: 25,
              //     fontWeight: FontWeight.w600,
              //     height: 1.25,
              //   ),
              // ),
              // const SizedBox(height: 20),
              Column(
                children: [
                  const YourCompanyLogo(), // Replace with your widget to handle company logo
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TimelineNavigationButton(
                        isSelected: true,
                        onPress: () => cp.companyProfileBackPage(),
                        navDirection: "back",
                      ),
                      TimelineNavigationButton(
                        isSelected: true,
                        onPress: () {
                          if (cp.appUser?.photoUrl != null) {
                            // Update the condition to check for company logo
                            cp.companyProfileNextPage();
                          }
                        },
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     cp.companyProfileBackPage();
                      //   },
                      //   child: Text(
                      //     AppLocalizations.of(context)!.previous,
                      //     style: TextStyle(
                      //       fontFamily: "Montserrat",
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      //   style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.all<Color>(
                      //         ThemeColors.secondaryThemeColor),
                      //   ),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     if (cp.appUser?.photoUrl != null) {
                      //       // Update the condition to check for company logo
                      //       cp.companyProfileNextPage();
                      //     }
                      //     ;
                      //   },
                      //   style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.all<Color>(
                      //         ThemeColors.secondaryThemeColor),
                      //   ),
                      //   child: Text(
                      //     AppLocalizations.of(context)!.next,
                      //     style: TextStyle(
                      //       fontFamily: "Montserrat",
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
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
