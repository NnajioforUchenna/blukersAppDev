import '../../../../../providers/worker_provider.dart';
import '../../../../../services/make_responsive_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import the necessary pages for the worker's timeline
import 'classification/classification_page.dart';
// import 'congratulation_page.dart'; // Name can be adjusted based on your actual page name
import 'personalInformation/personal_information_page.dart';
import 'professional_credentials/professional_credentials_page.dart';
import 'profile_photo_page.dart';
import 'reference/reference_page.dart';
import 'resume/resume_page.dart';
import 'work_experience/work_experience_page.dart';
import 'worker_congratulation_page.dart';

class WorkerPageSlider extends StatefulWidget {
  const WorkerPageSlider({super.key});

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

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          // padding: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(0),
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              MakeResponsiveWeb(
                  image: AssetImage('assets/images/classificationPage.png'),
                  child: ClassificationPage()),
              MakeResponsiveWeb(
                  image:
                      AssetImage('assets/images/personalInformationPage.png'),
                  child: PersonalInformationPage()),
              MakeResponsiveWeb(
                  image: AssetImage('assets/images/profilePhotoPage.png'),
                  child: ProfilePhotoPage()),
              MakeResponsiveWeb(
                  image: AssetImage(
                      'assets/images/professionalCredentialsPage.png'),
                  child: ProfessionalCredentialsPage()),
              MakeResponsiveWeb(
                  image: AssetImage('assets/images/workExperience.png'),
                  child: WorkExperiencePage()),
              MakeResponsiveWeb(
                  image: AssetImage('assets/images/referencePage.png'),
                  child: ReferencePage()),
              MakeResponsiveWeb(
                  image: AssetImage('assets/images/resumePage.png'),
                  child: ResumePage()),
              MakeResponsiveWeb(
                  image:
                      AssetImage('assets/images/workerCongratulationPage.png'),
                  child:
                      WorkerCongratulationPage()), // Name can be adjusted based on your actual page name
            ],
          ),
        ),
      ),
    );
  }
}
