import 'package:blukers/providers/worker_provider.dart';
import 'package:blukers/services/make_responsive_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import the necessary pages for the worker's timeline
import 'classification_page.dart';
// import 'congratulation_page.dart'; // Name can be adjusted based on your actual page name
import 'personal_information_page.dart';
import 'professional_credentials_page.dart';
import 'profile_photo_page.dart';
import 'reference_page.dart';
import 'resume_page.dart';
import 'work_experience_page.dart';
import 'worker_congratulation_page.dart';

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

    _currentPageIndex = Provider.of<WorkerProvider>(context, listen: false)
        .workerProfileCurrentPageIndex; // This might need to be adjusted for the worker's timeline
    _pageController = PageController(
      initialPage: _currentPageIndex,
    );
  }

  void animateToNextPage(index) {
    if (_currentPageIndex < 7) {
      // Adjusted for the 8 steps in WorkerPageSlider
      _pageController.animateToPage(
        index,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This provider might need to be adjusted for the worker's timeline
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    if (_currentPageIndex != wp.workerProfileCurrentPageIndex) {
      animateToNextPage(wp.workerProfileCurrentPageIndex);
      _currentPageIndex = wp.workerProfileCurrentPageIndex;
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MakeResponsiveWeb(
                image: const AssetImage('assets/images/classificationPage.png'),
                child: ClassificationPage()),
            MakeResponsiveWeb(
                image: const AssetImage(
                    'assets/images/personalInformationPage.png'),
                child: PersonalInformationPage()),
            MakeResponsiveWeb(
                image: const AssetImage('assets/images/profilePhotoPage.png'),
                child: ProfilePhotoPage()),
            const MakeResponsiveWeb(
                image:
                    AssetImage('assets/images/professionalCredentialsPage.png'),
                child: ProfessionalCredentialsPage()),
            MakeResponsiveWeb(
                image: const AssetImage('assets/images/workExperience.png'),
                child: WorkExperiencePage()),
            MakeResponsiveWeb(
                image: const AssetImage('assets/images/referencePage.png'),
                child: ReferencePage()),
            const MakeResponsiveWeb(
                image: AssetImage('assets/images/resumePage.png'),
                child: ResumePage()),
            const MakeResponsiveWeb(
                image: AssetImage('assets/images/workerCongratulationPage.png'),
                child:
                    WorkerCongratulationPage()), // Name can be adjusted based on your actual page name
          ],
        ),
      ),
    );
  }
}
