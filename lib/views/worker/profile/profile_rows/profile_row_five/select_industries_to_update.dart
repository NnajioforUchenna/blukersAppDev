import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../models/industry.dart';
import '../../../../../providers/industry_provider.dart';
import '../../../../../utils/localization/localized_industries.dart';
import '../../../../../utils/localization/localized_jobs.dart';

class SelectIndustriesToUpdate extends StatefulWidget {
  const SelectIndustriesToUpdate({super.key});

  @override
  State<SelectIndustriesToUpdate> createState() =>
      _SelectIndustriesToUpdateState();
}

class _SelectIndustriesToUpdateState extends State<SelectIndustriesToUpdate> {
  late List<Industry> industries;
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
    industries = ip.industries.values.toList();
    double width = MediaQuery.of(context).size.width;

    return Column(
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
                },
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: industries.indexOf(industry) % 2 == 0
                        ? Colors.grey[200]
                        : Colors.transparent,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocalizedIndustries.get(context, industry.industryId),
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: Checkbox(
                          value:
                              selectedIndustries.contains(industry.industryId),
                          onChanged: (bool? value) {
                            firstBoxFunction(value, industry);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (selectedIndustries.contains(industry.industryId))
                ...industry.jobs.map((job) {
                  return Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocalizedJobs.get(context, job.jobId),
                          style: TextStyle(
                            color: Colors.blueGrey[700],
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
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
                              isSelect();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
            ],
          );
        }).toList(),
      ],
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
