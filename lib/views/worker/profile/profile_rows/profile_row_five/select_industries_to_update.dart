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
    UserProvider up = Provider.of<UserProvider>(context, listen: false);
    IndustriesProvider ip =
        Provider.of<IndustriesProvider>(context, listen: false);
    industries = ip.industries.values.toList();

    if (up.appUser != null && up.appUser?.worker != null) {
      print('This is the industry ids Straight from the database');
      print(up.appUser?.worker?.industryIds);
      selectedIndustries = up.appUser?.worker?.industryIds ?? [];
      if (up.appUser?.worker?.jobIds != null && industries.isNotEmpty) {
        selectedJobs = {};
        for (String jobId in up.appUser!.worker!.jobIds!) {
          for (Industry industry in industries) {
            if (industry.jobs.any((job) => job.jobId == jobId)) {
              if (!selectedJobs.containsKey(industry.industryId)) {
                selectedJobs[industry.industryId] = [];
              }
              selectedJobs[industry.industryId]!.add(jobId);
            }
          }
        }
      }
    }

    super.initState();
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
                  ...industry.jobs.map((job) {
                    return InkWell(
                      onTap: () {
                        if (!selectedJobs.containsKey(industry.industryId)) {
                          selectedJobs[industry.industryId] = [];
                        }

                        if (selectedJobs[industry.industryId]
                                ?.contains(job.jobId) ??
                            false) {
                          setState(() {
                            selectedJobs[industry.industryId]!
                                .remove(job.jobId);
                          });
                        } else {
                          setState(() {
                            selectedJobs[industry.industryId]!.add(job.jobId);
                          });
                        }
                        up.updateAppUserCategory(
                            selectedIndustries, selectedJobs);
                        // isSelect();
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
                                LocalizedJobs.get(context, job.jobId),
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
                                        ?.contains(job.jobId) ??
                                    false,
                                onChanged: (bool? value) {
                                  if (value != null && value) {
                                    if (!selectedJobs
                                        .containsKey(industry.industryId)) {
                                      selectedJobs[industry.industryId] = [];
                                    }
                                    setState(() {
                                      selectedJobs[industry.industryId]!
                                          .add(job.jobId);
                                    });
                                  } else {
                                    setState(() {
                                      selectedJobs[industry.industryId]!
                                          .remove(job.jobId);
                                    });
                                  }
                                  up.updateAppUserCategory(
                                      selectedIndustries, selectedJobs);
                                  isSelect();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
              ],
            );
          }).toList(),
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
