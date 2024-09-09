import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import the package

import '../../../../providers/job_posts_provider.dart';
import 'additional_information_page.dart';
import 'basic_information_page.dart';
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
      height: MediaQuery.of(context).size.height * 0.87, 
      child: Stack(
        children: [
          Column(
            children: [
            
              Expanded(
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
              ),
            ],
          ),
     
          Positioned(
            bottom: 16, 
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: jp.createJobPostPageController, 
                count: 6, 
                effect: const WormEffect( 
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey,
                  dotHeight: 8.0,
                  dotWidth: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
