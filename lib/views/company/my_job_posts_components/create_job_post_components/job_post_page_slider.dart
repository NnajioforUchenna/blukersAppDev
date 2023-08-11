import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'additional_information_page.dart';
import 'basic_information_page.dart';
// import the required pages here
import 'classification_page.dart';
import 'compensation_and_contract_page.dart';
import 'job_post_congratulation_page.dart';
import 'qualification_and_skills_page.dart';

class JobPostPageSlider extends StatefulWidget {
  const JobPostPageSlider({
    Key? key,
  }) : super(key: key);

  @override
  _JobPostPageSliderState createState() => _JobPostPageSliderState();
}

class _JobPostPageSliderState extends State<JobPostPageSlider> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    _currentPageIndex = Provider.of<JobPostsProvider>(context, listen: false)
        .jobPostCurrentPageIndex;
    _pageController = PageController(
      initialPage: _currentPageIndex,
    );
  }

  void animateToNextPage(index) {
    if (_currentPageIndex < 5) {
      // modified to fit the 5 steps in JobPost
      _pageController.animateToPage(
        index,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    JobPostsProvider up = Provider.of<JobPostsProvider>(context);
    if (_currentPageIndex != up.jobPostCurrentPageIndex) {
      animateToNextPage(up.jobPostCurrentPageIndex);
      _currentPageIndex = up.jobPostCurrentPageIndex;
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ClassificationPage(),
          BasicInformationPage(),
          QualificationAndSkillsPage(),
          CompensationAndContractPage(),
          const AdditionalInformationPage(),
          const JobPostCongratulationPage(),
        ],
      ),
    );
  }
}
