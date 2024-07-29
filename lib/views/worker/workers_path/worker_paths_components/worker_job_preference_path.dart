import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/industry.dart';
import '../../../../../../providers/industry_provider.dart';
import '../../../../../../providers/worker_provider.dart';
import '../../../../../../services/responsive.dart';
import '../../../../../../utils/localization/localized_industries.dart';
import '../../../../../../utils/localization/localized_jobs.dart';

class JobPreferncePath extends StatefulWidget {
  const JobPreferncePath({super.key});

  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<JobPreferncePath> {
  late WorkerProvider wp;
  late List<Industry> industries;
  List<String> selectedIndustries = [];
  Map<String, List<String>> selectedJobs = {};

  ScrollController scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    wp = Provider.of<WorkerProvider>(context, listen: false);
    selectedIndustries = wp.previousParams['industries'] ?? [];
    selectedJobs = wp.previousParams['jobs'] ?? {};
  }

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    industries = ip.industries.values.toList();
    wp = Provider.of<WorkerProvider>(context);

    bool areJobsSelected() {
      return selectedJobs.entries.any((entry) => entry.value.isNotEmpty);
    }

    return Container(
      color: Colors.white,
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        controller: scrollCtrl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 80),
            const Text(
              "Select Job Preference",
              style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            if (industries.isEmpty)
              const Center(child: CircularProgressIndicator()),
            ...industries.expand((industry) {
              return [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 243, 243, 243),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: Text(
                          LocalizedIndustries.get(context, industry.name),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                          ),
                        ),
                        value: selectedIndustries.contains(industry.industryId),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value ?? false) {
                              selectedIndustries.add(industry.industryId);
                            } else {
                              selectedIndustries.remove(industry.industryId);
                              selectedJobs.remove(industry.industryId);
                            }
                          });
                        },
                      ),
                      if (selectedIndustries.contains(industry.industryId))
                        ...industry.jobs.entries.map((entry) {
                          final jobId = entry.value.title;
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: CheckboxListTile(
                              title: Text(
                                LocalizedJobs.get(context, jobId),
                                style: TextStyle(
                                  color: Colors.blueGrey[700],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200,
                                  height: 1.25,
                                ),
                              ),
                              value: selectedJobs[industry.industryId]
                                      ?.contains(jobId) ??
                                  false,
                              onChanged: (bool? value) {
                                if (!selectedJobs
                                    .containsKey(industry.industryId)) {
                                  selectedJobs[industry.industryId] = [];
                                }
                                setState(() {
                                  if (value == true) {
                                    selectedJobs[industry.industryId]!
                                        .add(jobId);
                                  } else {
                                    selectedJobs[industry.industryId]!
                                        .remove(jobId);
                                  }
                                });
                              },
                            ),
                          );
                        }),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Space between industry boxes
              ];
            }).toList(),
            const SizedBox(height: 40),

            const SizedBox(height: 20), // Reduced the space here
          ],
        ),
      ),
    );
  }
}
