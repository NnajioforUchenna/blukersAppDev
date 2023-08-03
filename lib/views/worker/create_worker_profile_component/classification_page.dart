import 'package:bulkers/providers/worker_provider.dart';
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
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
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
            if (industries.isEmpty)
              const Center(child: CircularProgressIndicator()),
            ...industries.map((industry) {
              return Column(
                children: [
                  CheckboxListTile(
                    title: Text(industry.name,
                        style: GoogleFonts.ebGaramond(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        )),
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
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: CheckboxListTile(
                          title: Text(job.title,
                              style: GoogleFonts.ebGaramond(
                                color: Colors.blueGrey[700],
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                                height: 1.25,
                              )),
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
                          },
                        ),
                      );
                    }).toList()
                ],
              );
            }).toList(),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    wp.createWorkerProfile(selectedIndustries, selectedJobs);
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
