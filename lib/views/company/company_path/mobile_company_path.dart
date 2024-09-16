import 'package:blukers/data_providers/user_data_provider.dart';
import 'package:blukers/models/app_user/app_user.dart';
import 'package:blukers/views/old_common_views/job_timeline/my_job_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/index.dart';
import '../../../utils/styles/theme_colors.dart';

class MobileCompanyPath extends StatelessWidget {
  const MobileCompanyPath({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    int currentStep = up.appUser?.companyTimelineStep ??
        0; // Change this accordingly for company
    AppUser? appUser;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),
            Center(
              child: SvgPicture.asset(
                'assets/icons/find_jobs.svg',
              ),
            ),
            Center(
              child: SizedBox(
                width: 173.w,
                child: Text(
                  "${AppLocalizations.of(context)!.find} ${AppLocalizations.of(context)!.workers} ${AppLocalizations.of(context)!.inBluckers}",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    // fontFamily: "Montserrat",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 72,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: companyRecords.length,
              itemBuilder: (context, index) {
                String title = "";
                String description = "";
                if (index == 0) {
                  title =
                      AppLocalizations.of(context)!.companyJourneyStep1Title;
                  description =
                      AppLocalizations.of(context)!.companyJourneyStep1Text;
                }
                if (index == 1) {
                  title =
                      AppLocalizations.of(context)!.companyJourneyStep2Title;
                  description =
                      AppLocalizations.of(context)!.companyJourneyStep2Text;
                }
                if (index == 2) {
                  title =
                      AppLocalizations.of(context)!.companyJourneyStep3Title;
                  description =
                      AppLocalizations.of(context)!.companyJourneyStep3Text;
                }
                if (index == 3) {
                  title =
                      AppLocalizations.of(context)!.companyJourneyStep4Title;
                  description =
                      AppLocalizations.of(context)!.companyJourneyStep4Text;
                }
                if (index == 4) {
                  title =
                      AppLocalizations.of(context)!.companyJourneyStep5Title;
                  description =
                      AppLocalizations.of(context)!.companyJourneyStep5Text;
                }
                if (index == 5) {
                  title =
                      AppLocalizations.of(context)!.companyJourneyStep6Title;
                  description =
                      AppLocalizations.of(context)!.companyJourneyStep6Text;
                }
                final record = companyRecords[index];
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
            const SizedBox(height: 10),
            if (currentStep == 0)
              buildButton(
                width,
                currentStep,
                AppLocalizations.of(context)!.companyJourneyStep1Title,
                context,
                () {
                  context.go('/register');
                },
              ),
            if (currentStep == 1)
              buildButton(
                width,
                currentStep,
                AppLocalizations.of(context)!.companyJourneyStep2Title,
                context,
                () {
                  context.go('/setWorkersPreferences');
                },
              ),
            if (currentStep == 2)
              buildButton(
                width,
                currentStep,
                AppLocalizations.of(context)!.companyJourneyStep3Title,
                context,
                () {
                  UserDataProvider.updatecompanyTimelineStep(appUser!.uid, 3);
                  context.go('/myJobPosts');
                },
              ),
            if (currentStep == 3)
              buildButton(
                width,
                currentStep,
                AppLocalizations.of(context)!.companyJourneyStep4Title,
                context,
                () {
                  context.go('/createCompanyProfile');
                },
              ),
            if (currentStep == 4)
              buildButton(
                width,
                currentStep,
                AppLocalizations.of(context)!.companyJourneyStep5Title,
                context,
                () {
                  context.go('/createJobPost');
                },
              ),
            if (currentStep == 5)
              buildButton(
                width,
                currentStep,
                AppLocalizations.of(context)!.companyJourneyStep6Title,
                context,
                () {
                  context.go('/companyChat');
                },
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Define the company records and the current step here
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

Widget buildButton(double width, int currentStep, String text,
    BuildContext context, VoidCallback onClick) {
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
