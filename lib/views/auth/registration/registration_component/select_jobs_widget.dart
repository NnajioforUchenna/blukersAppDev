import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../models/industry.dart';
import '../../../../providers/industry_provider.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../utils/localization/localized_jobs.dart';

class SelectJobsWidget extends StatefulWidget {
  const SelectJobsWidget({super.key});

  @override
  State<SelectJobsWidget> createState() => _SelectJobsWidgetState();
}

class _SelectJobsWidgetState extends State<SelectJobsWidget> {
  List<Industry> industries = [];
  List<String> selectedIndustries = [];
  Map<String, List<String>> selectedJobs = {};
  bool isSelected = false;

  isSelect() {
    setState(() {
      isSelected = selectedJobs.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    industries = ip.industries.values.toList();
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          ...industries.map((industry) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    if (selectedIndustries.contains(industry.industryId)) {
                      setState(() {
                        selectedIndustries.remove(industry.industryId);
                        selectedJobs.remove(industry.industryId);
                      });
                    } else {
                      setState(() {
                        selectedIndustries.add(industry.industryId);
                      });
                    }
                    isSelect();
                    up.updateJobsPreference(selectedIndustries, selectedJobs);
                  },
                  child: Container(
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: industries.indexOf(industry) % 2 == 0
                          ? Colors.grey[200]
                          : Colors.transparent,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            industry.name,
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.7,
                          child: Checkbox(
                            value: selectedIndustries
                                .contains(industry.industryId),
                            onChanged: (bool? value) {
                              firstBoxFunction(value, industry);
                              up.updateJobsPreference(
                                  selectedIndustries, selectedJobs);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (selectedIndustries.contains(industry.industryId))
                  ...industry.jobs.entries.map((entry) {
                    final jobId = entry.value.title;
                    return InkWell(
                      onTap: () {
                        if (!selectedJobs.containsKey(industry.industryId)) {
                          selectedJobs[industry.industryId] = [];
                        }

                        if (selectedJobs[industry.industryId]
                                ?.contains(jobId) ??
                            false) {
                          setState(() {
                            selectedJobs[industry.industryId]!.remove(jobId);
                          });
                        } else {
                          setState(() {
                            selectedJobs[industry.industryId]!.add(jobId);
                          });
                        }
                        up.updateJobsPreference(
                            selectedIndustries, selectedJobs);
                        // isSelect(); // Ensure the isSelect method is defined or remove this comment
                      },
                      child: Container(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                LocalizedJobs.get(context, jobId),
                                // Assuming LocalizedJobs.get can handle jobId
                                style: TextStyle(
                                  color: Colors.blueGrey[700],
                                  fontSize: 10,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                            Transform.scale(
                              scale: 0.6,
                              child: Checkbox(
                                value: selectedJobs[industry.industryId]
                                        ?.contains(jobId) ??
                                    false,
                                onChanged: (bool? value) {
                                  if (!selectedJobs
                                      .containsKey(industry.industryId)) {
                                    selectedJobs[industry.industryId] = [];
                                  }
                                  if (value == true) {
                                    setState(() {
                                      selectedJobs[industry.industryId]!
                                          .add(jobId);
                                    });
                                  } else {
                                    setState(() {
                                      selectedJobs[industry.industryId]!
                                          .remove(jobId);
                                    });
                                  }
                                  up.updateJobsPreference(
                                      selectedIndustries, selectedJobs);
                                  // isSelect(); // Ensure the isSelect method is defined or remove this comment
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              ],
            );
          }),
        ],
      ),
    );
  }

  void firstBoxFunction(value, industry) {
    if (value != null && value) {
      setState(() {
        selectedIndustries.add(industry.industryId);
      });
    } else {
      setState(() {
        selectedIndustries.remove(industry.industryId);
        selectedJobs.remove(industry.industryId);
      });
    }
  }
}
