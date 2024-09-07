import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'create_job_post_components/job_post_page_slider.dart';
import 'create_job_post_components/job_post_time_line.dart';

class CreateJobPostWeb extends StatelessWidget {
  const CreateJobPostWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createJobPost),
      ),
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment
                  .center, // Centers the container within the Flexible widget
              child: Container(
                width: 700, // Fixed width for consistency
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(
                    bottom: 10,),
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: JobStepCard(),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment
                  .center, // Centers the container within the Flexible widget
              child: Container(
                color: Color.fromARGB(255, 6, 46, 177),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(
                    left: 8.0, right: 70.0), // Adjust right margin as needed
                width: 700, // Fixed width for consistency
                child: Column(
                  children: [
                    JobPostTimeline(),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                const JobPostPageSlider(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JobStepCard extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
  return Stack(
    children: [
      Positioned(
        bottom: 0, // Aligns the image to the bottom of the Stack
        right: 0,  // Aligns the image to the right of the Stack
        child: Image.asset(
          'assets/images/createjobblukericon.png', // Ensure this path is correct
          height: 300,
          width: 300,
          fit: BoxFit.contain,
        ),
      ),
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const StepButton(
              text: 'Industry and job position',
              isHighlighted: true,
              icon: Icons.work_outline,
            ),
            StepArrow(),
            const StepButton(
              text: 'Job details',
              icon: Icons.info_outline,
            ),
            StepArrow(),
            const StepButton(
              text: 'Requirements and Skills',
              icon: Icons.list_alt,
            ),
            StepArrow(),
            const StepButton(
              text: 'Compensation and contract',
              icon: Icons.attach_money,
            ),
            StepArrow(),
            const StepButton(
              text: 'Job Location',
              icon: Icons.location_on_outlined,
            ),
          ],
        ),
      ),
    ],
  );
}

}

class StepButton extends StatelessWidget {
  final String text;
  final bool isHighlighted;
  final IconData icon;

  const StepButton({
    required this.text,
    this.isHighlighted = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
          minHeight: 60,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: isHighlighted ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isHighlighted ? null : Border.all(color: Colors.white70),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max, // Ensure it takes up full width
            children: [
              Icon(
                icon,
                color: isHighlighted ? Colors.orange : Colors.white,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: isHighlighted ? Colors.orange : Colors.white,
                    fontWeight:
                        isHighlighted ? FontWeight.bold : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StepArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Icon(
        Icons.arrow_downward,
        color: Colors.white,
      ),
    );
  }
}
