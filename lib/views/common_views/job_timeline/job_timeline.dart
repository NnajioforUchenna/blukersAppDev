import 'package:bulkers/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';
import 'my_job_timeline.dart';

class JobTimeline extends StatelessWidget {
  const JobTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    int currentStep = up.workerTimelineStep;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'Journey to Your Dream Job',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: jobRecords.length,
            itemBuilder: (context, index) {
              final record = jobRecords[index];
              return MyJobTimeLine(
                isFirst: index == 0,
                isLast: index == jobRecords.length - 1,
                isPast: index <= currentStep,
                title: record['title']!,
                briefDescription: record['description']!,
              );
            },
          ),
          const SizedBox(height: 10),
          if (currentStep == 0) buildButton(width, "Register", context),
          if (currentStep == 1)
            buildButton(width, "Create Your Profile", context),
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
  {
    'title': 'Apply for Jobs or Save to Apply Later',
    'description':
        'Browse through our extensive list of job postings. Find the ones that resonate with your career goals and apply directly through our platform. Not ready to apply just yet? No problem! You can save any job posting and return to it later when you\'re ready. Your dream job is just a click away.',
  },
  {
    'title': 'Companies Interested in Your Skill Set Will Reach Out to You',
    'description':
        'Your skills and experience are valuable, and companies are looking for talents like you. By having a complete and detailed profile, you may catch the eye of recruiters actively seeking your expertise. When a match is found, companies will reach out to you directly through our platform. Stay active, keep your profile up-to-date, and let the opportunities come to you.',
  },
];

Widget buildButton(double width, String text, context) {
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
          if (text == "Register") {
            Navigator.pushNamed(context, '/register');
          } else if (text == "Create Your Profile") {
            Navigator.pushNamed(context, '/createWorkerProfile');
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
