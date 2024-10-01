import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../models/industry.dart';
import '../../../../../providers/industry_provider.dart';
import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../utils/localization/localized_industries.dart';
import '../../../../../utils/localization/localized_jobs.dart';

class SelectIndustriesToUpdate extends StatefulWidget {
  const SelectIndustriesToUpdate({super.key});

  @override
  State<SelectIndustriesToUpdate> createState() =>
      _SelectIndustriesToUpdateState();
}

class _SelectIndustriesToUpdateState extends State<SelectIndustriesToUpdate> {
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
  void initState() {
    super
        .initState(); // It's recommended to call super.initState() at the beginning

    UserProvider up = Provider.of<UserProvider>(context, listen: false);
    IndustriesProvider ip =
        Provider.of<IndustriesProvider>(context, listen: false);
    industries = ip.industries.values.toList();

    if (up.appUser != null && up.appUser?.workerResumeDetails != null) {
      selectedIndustries = up.appUser?.workerResumeDetails?.industryIds ?? [];
      if (up.appUser?.workerResumeDetails?.jobIds != null &&
          industries.isNotEmpty) {
        selectedJobs = {};
        for (String jobId in up.appUser!.workerResumeDetails!.jobIds!) {
          for (Industry industry in industries) {
            // Since jobs is a Map, use .containsKey to check if jobId exists
            if (industry.jobs.containsKey(jobId)) {
              // Add jobId to the selectedJobs map under the correct industryId
              selectedJobs
                  .putIfAbsent(industry.industryId, () => [])
                  .add(jobId);
            }
          }
        }
      }
    }
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
                    up.updateAppUserCategory(selectedIndustries, selectedJobs);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFD9D9D9),
                        width: 1,
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            LocalizedIndustries.get(
                                context, industry.industryId),
                            style: GoogleFonts.montserrat(
                              color: const Color(0xFF595959),
                              fontSize: Responsive.isMobile(context) ? 13 : 20,
                              fontWeight: FontWeight.w600,
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
                              up.updateAppUserCategory(
                                  selectedIndustries, selectedJobs);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (selectedIndustries.contains(industry.industryId))
                  Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        children: [
                          ...industry.jobs.entries.map((entry) {
                            final jobId = entry.key;
                            return InkWell(
                              onTap: () {
                                if (!selectedJobs
                                    .containsKey(industry.industryId)) {
                                  selectedJobs[industry.industryId] = [];
                                }

                                if (selectedJobs[industry.industryId]
                                        ?.contains(jobId) ??
                                    false) {
                                  setState(() {
                                    selectedJobs[industry.industryId]!
                                        .remove(jobId);
                                  });
                                } else {
                                  setState(() {
                                    selectedJobs[industry.industryId]!
                                        .add(jobId);
                                  });
                                }
                                up.updateAppUserCategory(
                                    selectedIndustries, selectedJobs);
                                // isSelect(); // Ensure the isSelect method is defined or remove this comment
                              },
                              child: Container(
                                height: 20,
                                margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.1,
                                  vertical: 5
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.1),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        LocalizedJobs.get(context, jobId),
                                        style: TextStyle(
                                          color: Colors.blueGrey[700],
                                          fontSize: Responsive.isMobile(context)
                                              ? 14
                                              : 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Checkbox(
                                        value: selectedJobs[industry.industryId]
                                                ?.contains(jobId) ??
                                            false,
                                        onChanged: (bool? value) {
                                          if (!selectedJobs.containsKey(
                                              industry.industryId)) {
                                            selectedJobs[industry.industryId] =
                                                [];
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
                                          up.updateAppUserCategory(
                                              selectedIndustries, selectedJobs);
                                          // isSelect(); // Ensure the isSelect method is defined or remove this comment
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                        ],
                      ))
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
