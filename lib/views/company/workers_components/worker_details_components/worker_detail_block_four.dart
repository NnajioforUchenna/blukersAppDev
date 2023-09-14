import 'package:flutter/material.dart';

import '../../../../models/work_experience.dart';
import '../../../../services/responsive.dart';

// Make sure to import the location model if required
class WorkerDetailBlockFour extends StatelessWidget {
  final List<WorkExperience> workExperiences;

  const WorkerDetailBlockFour({Key? key, required this.workExperiences})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scaleFactor = Responsive.textScaleFactor(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Work Experience",
            style: TextStyle(
                fontSize: 20 * scaleFactor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          ...workExperiences
              .map((experience) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Company: ${experience.companyName}",
                        style: TextStyle(fontSize: 18 * scaleFactor),
                      ),
                      if (experience.location != null)
                        Text(
                          "Location: ${experience.location!.city}, ${experience.location!.country}",
                          style: TextStyle(fontSize: 18 * scaleFactor),
                        ),
                      Text(
                        "Job Title: ${experience.jobTitle}",
                        style: TextStyle(fontSize: 18 * scaleFactor),
                      ),
                      Text(
                        "Description: ${experience.jobDescription}",
                        style: TextStyle(fontSize: 18 * scaleFactor),
                      ),
                      Text(
                        "Start Date: ${experience.jobStartDate?.toLocal()}",
                        style: TextStyle(fontSize: 18 * scaleFactor),
                      ),
                      if (experience.isCurrentlyWorking)
                        Text("Currently Working",
                            style: TextStyle(
                                fontSize: 18 * scaleFactor,
                                color: Colors.green)),
                      if (experience.jobEndDate != null)
                        Text("End Date: ${experience.jobEndDate?.toLocal()}",
                            style: TextStyle(fontSize: 18 * scaleFactor)),
                      const SizedBox(height: 15),
                    ],
                  ))
              .toList(),
          const Divider(),
        ],
      ),
    );
  }
}
