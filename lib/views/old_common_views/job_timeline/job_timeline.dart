import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/index.dart';
import '../../../utils/styles/theme_colors.dart';
import 'my_job_timeline.dart';

class JobTimeline extends StatelessWidget {
  const JobTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    int currentStep = up.workerTimelineStep;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         SizedBox(height: Responsive.isMobile(context) || Responsive.isTablet(context) ? 60 : 0),
          if(Responsive.isMobile(context) || Responsive.isTablet(context)) const Center(
              child: Image(
                image: AssetImage('assets/images/worker_job_insp.png'),
              ),
            ),
        if(Responsive.isMobile(context) || Responsive.isTablet(context)) Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.workerJourneyTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.blukersBlueThemeColor,
                  fontFamily: "Montserrat",
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: Responsive.isMobile(context) || Responsive.isTablet(context) ? 30 : 0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: jobRecords.length,
            itemBuilder: (context, index) {
              String title = "";
              String description = "";
              if (index == 0) {
                title = AppLocalizations.of(context)!.workerJourneyStep1Title;
                description =
                    AppLocalizations.of(context)!.workerJourneyStep1Text;
              }
              if (index != 0) {
                title = AppLocalizations.of(context)!.workerJourneyStep3Title;
                description =
                    AppLocalizations.of(context)!.workerJourneyStep3Text;
              }
              return MyJobTimeLine(
                index: index,
                isFirst: index == 0,
                isLast: index == jobRecords.length - 1,
                isPast: index <= currentStep,
                isCurrent: index == currentStep,
                title: title,
                briefDescription: description,
              );
            },
          ),
          SizedBox(height: width < 600 ? 20 : 50),
          if (currentStep == 0)
            buildButton(
              width,
              currentStep,
              AppLocalizations.of(context)!.register,
              context,
              () {
                context.go('/register');
              },
            ),
          if (currentStep != 0)
            buildButton(
              width,
              currentStep,
              AppLocalizations.of(context)!.createProfile,
              context,
              () {
                context.go('/createResume');
              },
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Define the job records and the current step here
final jobRecords = [
  {
    'title': 'Register',
    'description':
        'Start your journey with us by creating an account. Registration is quick and easy. With just a few clicks, you\'ll gain access to countless job opportunities tailored to your interests and skills. Join us now and open the door to your next career adventure.',
  },
  {
    'title': 'Create Your Profile',
    'description':
        'Your profile is your professional showcase. Fill in your educational background, work experience, skills, and more. The more complete your profile, the easier it will be for employers to understand your expertise and reach out with relevant job offers. A well-crafted profile can make you stand out in the competitive job market.',
  },
  // {
  //   'title': 'Apply for Jobs or Save to Apply Later',
  //   'description':
  //       'Browse through our extensive list of job postings. Find the ones that resonate with your career goals and apply directly through our platform. Not ready to apply just yet? No problem! You can save any job posting and return to it later when you\'re ready. Your dream job is just a click away.',
  // },
  // {
  //   'title': 'Companies Interested in Your Skill Set Will Reach Out to You',
  //   'description':
  //       'Your skills and experience are valuable, and companies are looking for talents like you. By having a complete and detailed profile, you may catch the eye of recruiters actively seeking your expertise. When a match is found, companies will reach out to you directly through our platform. Stay active, keep your profile up-to-date, and let the opportunities come to you.',
  // },
];

Widget buildButton(
    double width, int currentStep, String text, context, onClick) {
  return Center(
    child: SizedBox(
      width: width < 600 ? 350 : 400, // 300 on mobile, 500 on web or tablet
      height: width < 600 ? 50 : 80, // 70 on mobile, 100 on web or tablet
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // backgroundColor: ThemeColors.secondaryThemeColor,
          backgroundColor: ThemeColors.blukersOrangeThemeColor,
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24 * Responsive.textScaleFactor(context),
            ),
          ),
        ),
      ),
    ),
  );
}
