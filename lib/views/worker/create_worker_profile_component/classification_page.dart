import 'package:bulkers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/industry.dart';
import '../../../providers/industry_provider.dart';
import '../../../services/responsive.dart';

class ClassificationPage extends StatefulWidget {
  ClassificationPage({Key? key}) : super(key: key);

  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  late WorkerProvider wp;
  late List<Industry> industries;
  List<String> selectedIndustries = [];
  Map<String, List<String>> selectedJobs = {};
  bool isSelected = false;
  isSelect() {
    setState(() {
      if (selectedJobs.isNotEmpty) {
        isSelected = true;
      } else {
        isSelected = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    wp = Provider.of<WorkerProvider>(context, listen: false);
    selectedIndustries = wp.previousParams['industries'] ?? [];
    selectedJobs = wp.previousParams['jobs'] ?? {};
    isSelect(); // Check if something is selected on initialization
  }

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    industries = ip.industries.values.toList();
    wp = Provider.of<WorkerProvider>(context);
    return Container(
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Select Your Industries and Jobs",
              textAlign: TextAlign.center,
              style: TextStyle(
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
                        style: const TextStyle(
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
                              style: TextStyle(
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
                            isSelect();
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
                const Spacer(),
                ElevatedButton(
                  onPressed: !isSelected
                      ? null
                      : () {
                          wp.createWorkerProfile(
                              context, selectedIndustries, selectedJobs);
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        isSelected ? Colors.deepOrangeAccent : Colors.grey),
                  ),
                  child: const Text("Next"),
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
