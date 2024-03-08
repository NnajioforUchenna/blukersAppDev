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

    if (up.appUser != null && up.appUser?.worker != null) {
      selectedIndustries = up.appUser?.worker?.industryIds ?? [];
      if (up.appUser?.worker?.jobIds != null && industries.isNotEmpty) {
        selectedJobs = {};
        for (String jobId in up.appUser!.worker!.jobIds) {
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
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: industries.indexOf(industry) % 2 == 0
                          ? Colors.grey[200]
                          : Colors.transparent,
                    ),
                    margin: EdgeInsets.only(
                      right: width * 0.05,
                      left: width * 0.05,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            LocalizedIndustries.get(
                                context, industry.industryId),
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
                  ...industry.jobs.entries.map((entry) {
                    final jobId = entry.key;
                    final job = entry.value;
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
                        up.updateAppUserCategory(
                            selectedIndustries, selectedJobs);
                        // isSelect(); // Ensure the isSelect method is defined or remove this comment
                      },
                      child: Container(
                        height: 20,
                        margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                LocalizedJobs.get(context,
                                    jobId), // Assuming LocalizedJobs.get can handle jobId
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
