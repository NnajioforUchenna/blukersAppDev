import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/worker_provider.dart';
import 'work_experience_form.dart';

class WorkExperiencePage extends StatelessWidget {
  WorkExperiencePage({super.key});
  List<WorkExperienceForm> workExperienceForms = [];

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    for (int i = 0; i < wp.workExperience.length; i++) {
      workExperienceForms.add(WorkExperienceForm(index: i));
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...workExperienceForms,
            Tooltip(
              message: "Add more Work Experience",
              child: InkWell(
                onTap: () {
                  wp.addWorkExperience();
                },
                child: Row(
                  children: [
                    Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        wp.addWorkExperience();
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Add more Work Experience",
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
