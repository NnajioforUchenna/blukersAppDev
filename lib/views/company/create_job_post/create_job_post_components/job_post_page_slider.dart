import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_posts_provider.dart';
import 'additional_information_page.dart';
import 'basic_information_page.dart';
// import the required pages here
import 'classification_page.dart';
import 'compensation_and_contract_page.dart';
import 'job_post_congratulation_page.dart';
import 'qualification_and_skills_page.dart';

class JobPostPageSlider extends StatefulWidget {
  const JobPostPageSlider({super.key});

  @override
  State<JobPostPageSlider> createState() => _JobPostPageSliderState();
}

class _JobPostPageSliderState extends State<JobPostPageSlider> {
  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: PageView(
        controller: jp.createJobPostPageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ClassificationPage(),
          BasicInformationPage(),
          QualificationAndSkillsPage(),
          CompensationAndContractPage(),
          AdditionalInformationPage(),
          JobPostCongratulationPage(),
        ],
      ),
    );
  }
}
