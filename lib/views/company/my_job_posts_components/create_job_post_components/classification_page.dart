import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../models/industry.dart';
import '../../../../providers/industry_provider.dart';
import '../../../../providers/job_posts_provider.dart';
import '../../../auth/common_widget/submit_button.dart';

class ClassificationPage extends StatefulWidget {
  ClassificationPage({Key? key}) : super(key: key);

  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  String? selectedIndustryId;
  String? selectedJobId;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    List<Industry> industries = ip.industries.values.toList();
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return SizedBox(
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Select Industry",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    items: industries.map((industry) {
                      return DropdownMenuItem(
                        child: Text(industry.name),
                        value: industry.industryId,
                      );
                    }).toList(),
                    onChanged: (industryId) {
                      setState(() {
                        selectedIndustryId = industryId;
                        selectedJobId = null; // Reset job selection
                      });
                    },
                    value: selectedIndustryId,
                    decoration: InputDecoration(
                      labelText: "Industry",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (selectedIndustryId != null) ...[
                    Text(
                      "Select Job",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      items: industries
                          .firstWhere((i) => i.industryId == selectedIndustryId)
                          .jobs
                          .map((job) {
                        return DropdownMenuItem(
                          child: Text(job.title),
                          value: job.jobId,
                        );
                      }).toList(),
                      onChanged: (jobId) {
                        setState(() {
                          selectedJobId = jobId;
                        });
                      },
                      value: selectedJobId,
                      decoration: InputDecoration(
                        labelText: "Job",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 40),
                  SubmitButton(
                    onTap: () {
                      if (selectedIndustryId != null && selectedJobId != null) {
                        jp.setIndustryAndJob(
                            selectedIndustryId!, selectedJobId!);
                        // Handle the next action or save the selection.
                      }
                    },
                    text: "Next",
                    isDisabled:
                        selectedIndustryId == null || selectedJobId == null,
                  ),
                  SizedBox(height: height * .05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
