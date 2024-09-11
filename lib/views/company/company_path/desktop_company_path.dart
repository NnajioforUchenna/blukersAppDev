import 'package:blukers/data_providers/user_data_provider.dart';
import 'package:blukers/models/app_user/app_user.dart';
import 'package:blukers/services/make_responsive_web.dart';
import 'package:blukers/views/old_common_views/job_timeline/my_job_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/index.dart';
import '../../../utils/styles/theme_colors.dart';

class DesktopCompanyPath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    int currentStep = up.appUser?.companyTimelineStep ?? 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 154),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/successpath.png',
                      width: 370,
                      height: 370,
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.companyJourneyTitle,
                        style: const TextStyle(
                          fontSize: 47,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.blukersBlueThemeColor,
                          fontFamily: "Montserrat",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 116),
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 60),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: companyRecords.length,
                            itemBuilder: (context, index) {
                              String title = getTitle(index, context);
                              String description =
                                  getDescription(index, context);

                              return MyJobTimeLine(
                                index: index,
                                isFirst: index == 0,
                                isLast: index == companyRecords.length - 1,
                                isPast: index <= currentStep,
                                isCurrent: index == currentStep,
                                title: title,
                                briefDescription: description,
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    if (currentStep >= 0 && currentStep <= 5)
                      Positioned(
                        bottom: 10,
                        right: 0,
                        left: 0,
                        child: buildButton(
                          context,
                          currentStep,
                          getButtonTitle(currentStep, context),
                          () {
                            navigateBasedOnStep(currentStep, context);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getTitle(int index, BuildContext context) {
    switch (index) {
      case 0:
        return AppLocalizations.of(context)!.companyJourneyStep1Title;
      case 1:
        return AppLocalizations.of(context)!.companyJourneyStep2Title;
      case 2:
        return AppLocalizations.of(context)!.companyJourneyStep3Title;
      case 3:
        return AppLocalizations.of(context)!.companyJourneyStep4Title;
      case 4:
        return AppLocalizations.of(context)!.companyJourneyStep5Title;
      case 5:
        return AppLocalizations.of(context)!.companyJourneyStep6Title;
      default:
        return '';
    }
  }

  String getDescription(int index, BuildContext context) {
    switch (index) {
      case 0:
        return AppLocalizations.of(context)!.companyJourneyStep1Text;
      case 1:
        return AppLocalizations.of(context)!.companyJourneyStep2Text;
      case 2:
        return AppLocalizations.of(context)!.companyJourneyStep3Text;
      case 3:
        return AppLocalizations.of(context)!.companyJourneyStep4Text;
      case 4:
        return AppLocalizations.of(context)!.companyJourneyStep5Text;
      case 5:
        return AppLocalizations.of(context)!.companyJourneyStep6Text;
      default:
        return '';
    }
  }

  String getButtonTitle(int currentStep, BuildContext context) {
    switch (currentStep) {
      case 0:
        return AppLocalizations.of(context)!.companyJourneyStep1Title;
      case 1:
        return AppLocalizations.of(context)!.companyJourneyStep2Title;
      case 2:
        return AppLocalizations.of(context)!.companyJourneyStep3Title;
      case 3:
        return AppLocalizations.of(context)!.companyJourneyStep4Title;
      case 4:
        return AppLocalizations.of(context)!.companyJourneyStep5Title;
      case 5:
        return AppLocalizations.of(context)!.companyJourneyStep6Title;
      default:
        return '';
    }
  }

  void navigateBasedOnStep(int currentStep, BuildContext context) {
    AppUser? appUser;
    switch (currentStep) {
      case 0:
        context.go('/register');
        break;
      case 1:
        context.go('/setWorkersPreferences');
        break;
      case 2:
        UserDataProvider.updatecompanyTimelineStep(appUser!.uid, 3);
        context.go('/myJobPosts');
        break;
      case 3:
        context.go('/createCompanyProfile');
        break;
      case 4:
        context.go('/createJobPost');
        break;
      case 5:
        context.go('/companyChat');
        break;
      default:
        break;
    }
  }
}

final companyRecords = [
  {
    'title': 'Register',
    'description':
        'Start your journey with us by creating an account. Registration is quick and easy. With just a few clicks, you\'ll gain access to countless job opportunities tailored to your interests and skills. Join us now and open the door to your next career adventure.',
  },
  {
    'title': 'Worker Preference',
    'description':
        'Specify your worker preferences to help us match you with the most relevant candidates. Define your desired job roles, locations, and other preferences to streamline your recruitment process.',
  },
  {
    'title': 'View Workers',
    'description':
        'Browse through our extensive list of workers and view their profiles. Find the best candidates that match your job requirements and get to know them better before making a decision.',
  },
  {
    'title': 'Create a Profile',
    'description':
        'Create a company profile to attract potential workers. A well-crafted profile can significantly increase your chances of finding the right candidates for your job openings.',
  },
  {
    'title': 'Create Job Posts',
    'description':
        'Post job openings and attract potential workers. Define the job roles, locations, and other details to help candidates understand the requirements and apply accordingly.',
  },
  {
    'title': 'Chat with Workers',
    'description':
        'If you see a candidate you like, congratulations! You can chat with the workers directly and get to know them better before making a hiring decision.',
  },
];

Widget buildButton(
  BuildContext context,
  int currentStep,
  String text,
  VoidCallback onClick,
) {
  double width = MediaQuery.of(context).size.width;

  return Center(
    child: SizedBox(
      width: width < 600 ? 250 : double.infinity,
      height: width < 600 ? 50 : 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColors.blukersOrangeThemeColor,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onClick,
        child: Center(
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
