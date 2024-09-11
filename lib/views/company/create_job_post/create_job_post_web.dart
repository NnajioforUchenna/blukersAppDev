// lib/screens/create_job_post_web.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_job_post_components/create_job_post_card.dart';
import 'create_job_post_components/job_post_page_slider.dart';

class CreateJobPostWeb extends StatelessWidget {
  const CreateJobPostWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 660,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(20),
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
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20.0, right: 30.0),
                  width: 650,
                  child: Column(
                    children: [
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
      ),
    );
  }
}
