import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';
import 'my_worker_timeline.dart';

import '../../../utils/styles/index.dart';
import 'package:unicons/unicons.dart';

class WorkerTimeline extends StatelessWidget {
  WorkerTimeline({super.key});

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
          const SizedBox(height: 60),
          const Center(
            child: Icon(
              UniconsLine.hard_hat,
              size: 60,
              color: ThemeColors.blukersBlueThemeColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.companyJourneyTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.blukersBlueThemeColor,
                  fontFamily: "Montserrat",
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
                title = AppLocalizations.of(context)!.companyJourneyStep4Title;
                description =
                    AppLocalizations.of(context)!.companyJourneyStep4Text;
              }
              // if (index == 2) {
              //   title = AppLocalizations.of(context)!.companyJourneyStep3Title;
              //   description =
              //       AppLocalizations.of(context)!.companyJourneyStep3Text;
              // }
              // if (index == 3) {
              //   title = AppLocalizations.of(context)!.companyJourneyStep4Title;
              //   description =
              //       AppLocalizations.of(context)!.companyJourneyStep4Text;
              // }
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
              () {
                context.go('/register');
              },
            ),
          if (currentStep == 1)
            BuildButton(
              width,
              currentStep,
              AppLocalizations.of(context)!.createProfile,
              context,
              () {
                context.go('/createCompanyProfile');
              },
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
    // {
    //   'title': 'View and Chats with Workers',
    //   'description':
    //       'Explore the profiles of professionals aligned with your requirements.',
    // },
    // {
    //   'title': 'Hire',
    //   'description':
    //       'Once you\'ve found the right candidates, extend your offers directly through our platform.',
    // },
  ];
}

Widget BuildButton(
    double width, int currentStep, String text, context, onClick) {
  return Center(
    child: SizedBox(
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
        onPressed: () => onClick(),
        child: Center(
          // Center the text inside the button
          child: Text(
            text.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24 * Responsive.textScaleFactor(context)),
          ),
        ),
      ),
    ),
  );
}
