import 'package:bulkers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/industry.dart';
import '../../../providers/industry_provider.dart';

class ClassificationPage extends StatefulWidget {
  ClassificationPage({Key? key}) : super(key: key);

  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  late List<Industry> industries;
  List<String> selectedIndustries = [];
  Map<String, List<String>> selectedJobs = {};

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    industries = ip.industries.values.toList();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Select Your Industries and Jobs",
              textAlign: TextAlign.center,
              style: GoogleFonts.ebGaramond(
                color: Colors.deepOrangeAccent,
                fontSize: 25,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 20),
            ...industries.map((industry) {
              return Column(
                children: [
                  CheckboxListTile(
                    title: Text(
                      industry.name,
                      style: G,
                    ),
                    value: selectedIndustries.contains(industry.industryId),
                    onChanged: (bool? value) {
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
                    },
                  ),
                  if (selectedIndustries.contains(industry.industryId))
                    ...industry.jobs.map((job) {
                      return CheckboxListTile(
                        title: Text(job.title),
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
                              selectedJobs[industry.industryId]!.add(job.jobId);
                            });
                          } else {
                            setState(() {
                              selectedJobs[industry.industryId]!
                                  .remove(job.jobId);
                            });
                          }
                        },
                      );
                    }).toList()
                ],
              );
            }).toList(),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go to the previous page
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ThemeColors.secondaryThemeColor),
                  ),
                  child: Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle saving or further processing of selected industries and jobs
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ThemeColors.secondaryThemeColor),
                  ),
                  child: const Text("Next"),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
