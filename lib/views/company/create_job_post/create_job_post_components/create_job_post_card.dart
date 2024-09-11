// lib/widgets/job_step_card.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/job_posts_provider.dart';
import 'create_job_step_button.dart';
import 'job_post_time_line.dart';
// Ensure to import this file

class JobStepCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jobPostsProvider = Provider.of<JobPostsProvider>(context);
    final currentStepIndex = jobPostsProvider.jobPostCurrentPageIndex;

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          child: Transform.translate(
            offset: const Offset(40, 0),
            child: Image.asset(
              'assets/images/createjobblukericon.png',
              height: 400,
              width: 400,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(jobPostSteps.length, (index) {
              return Column(
                children: [
                  StepButton(
                    text: jobPostSteps[index],
                    isHighlighted: index == currentStepIndex,
                    icon: jobPostIcons[index].icon!,
                    isCompleted: index < currentStepIndex,
                    onCompleted: (isCompleted) {
                      // Update the job post provider or perform other actions
                      jobPostsProvider.updateStepCompletion(index, isCompleted);
                    },
                  ),
                  if (index < jobPostSteps.length - 1)
                    Transform.translate(
                      offset: const Offset(-20, 0),
                      child: StepArrow(),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
