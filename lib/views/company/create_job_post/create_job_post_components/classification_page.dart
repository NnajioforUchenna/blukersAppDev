import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../models/industry.dart';
import '../../../../providers/industry_provider.dart';
import '../../../../providers/job_posts_provider.dart';
import "../../../../utils/localization/localized_industries.dart";
import "../../../../utils/localization/localized_jobs.dart";

class ClassificationPage extends StatefulWidget {
  const ClassificationPage({super.key});

  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  String? selectedIndustryId;
  String? selectedJobId;

  @override
  void initState() {
    super.initState();
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context, listen: false);
    selectedIndustryId = jp.previousParams['industryId'];
    selectedJobId = jp.previousParams['jobId'];
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    List<Industry> industries = ip.industries.values.toList();
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.createJobPost,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true, // Centers the title horizontally
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 60),
              Text(
                AppLocalizations.of(context)!.selectAnIndustry,
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              // Industry Dropdown with reduced width
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                height: 52, // Set to 85% of the screen width
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  items: industries.map((industry) {
                    return DropdownMenuItem(
                      value: industry.industryId,
                      child: Text(
                        LocalizedIndustries.get(
                          context,
                          industry.industryId,
                        ),
                      ),
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: AppLocalizations.of(context)!.industry,
                  ),
                ),
              ),
              const SizedBox(height: 45),
              if (selectedIndustryId != null) ...[
                Text(
                  AppLocalizations.of(context)!.selectAJobPosition,
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                // Job Position Dropdown with reduced width
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: 52,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    items: industries
                        .firstWhere((industry) =>
                            industry.industryId == selectedIndustryId)
                        .jobs
                        .entries
                        .map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(
                          LocalizedJobs.get(
                            context,
                            entry.key,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (jobId) {
                      setState(() {
                        selectedJobId = jobId;
                      });
                    },
                    value: selectedJobId,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: AppLocalizations.of(context)!.jobPosition,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Align "Next" button to the right
                children: [
                  ElevatedButton(
                    onPressed:
                        selectedIndustryId != null && selectedJobId != null
                            ? () {
                                jp.setIndustryAndJob(
                                    selectedIndustryId!, selectedJobId!);
                                // Handle the next action or save the selection.
                              }
                            : null, // Disable button if IDs are null
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange, // Background color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 20), // Increased padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded corners
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.next, // Text for the button
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16, // Increased font size
                        fontWeight: FontWeight.w600, // Font weight
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
