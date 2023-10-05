import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';
import 'my_worker_timeline.dart';

class WorkerTimeline extends StatelessWidget {
  WorkerTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    int currentStep = up
        .companyTimelineStep; // You might need to define the company timeline step
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.companyJourneyTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.primaryThemeColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: workerRecords.length,
            itemBuilder: (context, index) {
              String title = "";
              String description = "";
              if (index == 0) {
                title = AppLocalizations.of(context)!.companyJourneyStep1Title;
                description =
                    AppLocalizations.of(context)!.companyJourneyStep1Text;
              }
              if (index == 1) {
                title = AppLocalizations.of(context)!.companyJourneyStep2Title;
                description =
                    AppLocalizations.of(context)!.companyJourneyStep2Text;
              }
              if (index == 2) {
                title = AppLocalizations.of(context)!.companyJourneyStep3Title;
                description =
                    AppLocalizations.of(context)!.companyJourneyStep3Text;
              }
              if (index == 3) {
                title = AppLocalizations.of(context)!.companyJourneyStep4Title;
                description =
                    AppLocalizations.of(context)!.companyJourneyStep4Text;
              }
              final record = workerRecords[index];
              return MyWorkerTimeLine(
                // You might need to create or adapt MyJobTimeLine for worker flow
                isFirst: index == 0,
                isLast: index == workerRecords.length - 1,
                isPast: index <= currentStep,
                // title: record['title']!,
                // briefDescription: record['description']!,
                title: title,
                briefDescription: description,
              );
            },
          ),
          const SizedBox(height: 10),
          if (currentStep == 0)
            BuildButton(
              width,
              currentStep,
              AppLocalizations.of(context)!.register,
              context,
            ),
          if (currentStep == 1)
            BuildButton(
              width,
              currentStep,
              AppLocalizations.of(context)!.createCompanyProfile,
              context,
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  final workerRecords = [
    {
      'title': 'Register',
      'description': 'Join our platform today and find new opportunities.',
    },
    {
      'title': 'Create Company Profile',
      'description':
          'Your company profile is your brand\'s showcase on our platform.',
    },
    {
      'title': 'View and Chats with Workers',
      'description':
          'Explore the profiles of professionals aligned with your requirements.',
    },
    {
      'title': 'Hire',
      'description':
          'Once you\'ve found the right candidates, extend your offers directly through our platform.',
    },
  ];
}

Widget BuildButton(double width, int currentStep, String text, context) {
  return Center(
    child: Container(
      width: width < 600 ? 250 : 400, // 300 on mobile, 500 on web or tablet
      height: width < 600 ? 50 : 80, // 70 on mobile, 100 on web or tablet
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColors.secondaryThemeColor,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          // Add the functionality here
          // if (text == "Register") {
          //   context.go( '/register');
          // } else if (text == "Create Company Profile") {
          //   context.go( '/createCompanyProfile');
          // }
          if (currentStep == 0) {
            context.go('/register');
          } else if (currentStep == 1) {
            context.go('/createCompanyProfile');
          }
        }, // Add the functionality here
        child: Center(
          // Center the text inside the button
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20 * Responsive.textScaleFactor(context)),
          ),
        ),
      ),
    ),
  );
}
