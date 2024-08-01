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

class DesktopWorkerPath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    int currentStep = up.appUser?.workerTimelineStep ?? 0;

    return Scaffold(
      body: MakeResponsiveWeb(
        image: const AssetImage('../../../assets/images/successPath.png'),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Center(
                child: Icon(
                  UniconsLine.bag_alt,
                  size: 60,
                  color: ThemeColors.blukersBlueThemeColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.workerJourneyTitle,
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
                itemCount: jobRecords.length,
                itemBuilder: (context, index) {
                  String title = "";
                  String description = "";
                  if (index == 0) {
                    title =
                        AppLocalizations.of(context)!.workerJourneyStep1Title;
                    description =
                        AppLocalizations.of(context)!.workerJourneyStep1Text;
                  } else if (index == 1) {
                    title =
                        AppLocalizations.of(context)!.workerJourneyStep2Title;
                    description =
                        AppLocalizations.of(context)!.workerJourneyStep2Text;
                  } else if (index == 2) {
                    title =
                        AppLocalizations.of(context)!.workerJourneyStep3Title;
                    description =
                        AppLocalizations.of(context)!.workerJourneyStep3Text;
                  } else if (index == 3) {
                    title =
                        AppLocalizations.of(context)!.workerJourneyStep4Title;
                    description =
                        AppLocalizations.of(context)!.workerJourneyStep4Text;
                  } else if (index == 4) {
                    title =
                        AppLocalizations.of(context)!.workerJourneyStep5Title;
                    description =
                        AppLocalizations.of(context)!.workerJourneyStep5Text;
                  } else if (index == 5) {
                    title =
                        AppLocalizations.of(context)!.workerJourneyStep6Title;
                    description =
                        AppLocalizations.of(context)!.workerJourneyStep6Text;
                  }

                  final record = jobRecords[index];
                  return MyJobTimeLine(
                    isFirst: index == 0,
                    isLast: index == jobRecords.length - 1,
                    isPast: index <= currentStep,
                    title: title,
                    briefDescription: description,
                  );
                },
              ),
              const SizedBox(height: 10),
              if (currentStep == 0)
                buildButton(
                  context,
                  currentStep,
                  AppLocalizations.of(context)!.workerJourneyStep1Title,
                  () {
                    context.go('/register');
                  },
                ),
              if (currentStep == 1)
                buildButton(
                  context,
                  currentStep,
                  AppLocalizations.of(context)!.workerJourneyStep2Title,
                  () {
                    context.go('/jobPreference');
                  },
                ),
              if (currentStep == 2)
                buildButton(
                  context,
                  currentStep,
                  AppLocalizations.of(context)!.workerJourneyStep3Title,
                  () {
                    context.go('/createResume');
                  },
                ),
              if (currentStep == 3)
                buildButton(
                  context,
                  currentStep,
                  AppLocalizations.of(context)!.workerJourneyStep4Title,
                  () {
                    context.go('/myJobs');
                  },
                ),
              if (currentStep == 4)
                buildButton(
                  context,
                  currentStep,
                  AppLocalizations.of(context)!.subscribeToApplyMoreJobs,
                  () {
                    context.go('/offers');
                  },
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
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
    'title': 'Job Preference',
    'description':
        'Specify your job preferences to help us match you with the most relevant job opportunities. Define your desired job roles, locations, and other preferences to streamline your job search.',
  },
  {
    'title': 'Create a Resume',
    'description':
        'Create a professional resume to showcase your skills and experience to potential employers. A well-crafted resume can significantly increase your chances of landing your dream job.',
  },
  {
    'title': 'Apply to Jobs',
    'description':
        'Browse through our extensive list of job postings and apply directly to the ones that match your career goals. Take the next step towards your new career by submitting your applications.',
  },
  {
    'title': 'Subscribe to Apply to More Jobs',
    'description':
        'Subscribe to our premium service to unlock more job applications. Get access to exclusive job listings and increase your chances of finding the perfect job by applying to more opportunities.',
  },
  {
    'title':
        'If Employed, Congratulations! The Company Will Likely Process the Work Visa for This Job',
    'description':
        'If you get employed, congratulations! The company will likely process the work visa for this job, making your transition to the new role smoother and hassle-free.',
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
      width: width < 600 ? 250 : 400,
      height: width < 600 ? 50 : 80,
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
              fontWeight: FontWeight.bold,
              fontSize: 24 * Responsive.textScaleFactor(context),
            ),
          ),
        ),
      ),
    ),
  );
}
