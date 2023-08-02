import 'package:bulkers/providers/job_posts_provider.dart'; // This provider might need to be adjusted or replaced for the worker's timeline
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import the necessary pages for the worker's timeline
import 'classification_page.dart';
// import 'congratulation_page.dart'; // Name can be adjusted based on your actual page name
// import 'personal_information_page.dart';
// import 'profile_photo_page.dart';
// import 'references_page.dart';
// import 'resume_page.dart';
// import 'skills_page.dart';
// import 'work_experience_page.dart';

class WorkerPageSlider extends StatefulWidget {
  const WorkerPageSlider({Key? key}) : super(key: key);

  @override
  _WorkerPageSliderState createState() => _WorkerPageSliderState();
}

class _WorkerPageSliderState extends State<WorkerPageSlider> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    _currentPageIndex = Provider.of<JobPostsProvider>(context, listen: false)
        .jobPostCurrentPageIndex; // This might need to be adjusted for the worker's timeline
    _pageController = PageController(
      initialPage: _currentPageIndex,
    );
  }

  void animateToNextPage() {
    if (_currentPageIndex < 7) {
      // Adjusted for the 8 steps in WorkerPageSlider
      _pageController.animateToPage(
        _currentPageIndex + 1,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This provider might need to be adjusted for the worker's timeline
    JobPostsProvider up = Provider.of<JobPostsProvider>(context);
    if (_currentPageIndex != up.jobPostCurrentPageIndex) {
      animateToNextPage();
      _currentPageIndex = up.jobPostCurrentPageIndex;
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ClassificationPage(),
          // PersonalInformationPage(),
          // ProfilePhotoPage(),
          // SkillsPage(),
          // WorkExperiencePage(),
          // ReferencesPage(),
          // ResumePage(),
          // CongratulationPage(), // Name can be adjusted based on your actual page name
        ],
      ),
    );
  }
}
