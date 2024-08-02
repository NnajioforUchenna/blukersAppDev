import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../models/industry.dart';
import '../../../../providers/industry_provider.dart';
import '../../../../providers/job_posts_provider.dart';
import "../../../../utils/localization/localized_industries.dart";
import "../../../../utils/localization/localized_jobs.dart";
import '../../../auth/common_widget/submit_button.dart';

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
    return Stack(
      children: <Widget>[
        Container(
          height: height,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.selectAnIndustry,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    // height: 1.25,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
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
                      labelText: AppLocalizations.of(context)!.industry,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (selectedIndustryId != null) ...[
                  Text(
                    AppLocalizations.of(context)!.selectAJobPosition,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      items: industries
                          .firstWhere((industry) =>
                              industry.industryId == selectedIndustryId)
                          .jobs
                          .entries
                          .map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key, // The job ID is the key in the map
                          child: Text(
                            LocalizedJobs.get(
                              context,
                              entry
                                  .key, // Use the job ID to get the localized job name
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
                        labelText: AppLocalizations.of(context)!.jobPosition,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 40),
                SubmitButton(
                  onTap: () {
                    if (selectedIndustryId != null && selectedJobId != null) {
                      jp.setIndustryAndJob(selectedIndustryId!, selectedJobId!);
                      // Handle the next action or save the selection.
                    }
                  },
                  text: AppLocalizations.of(context)!.next,
                  isDisabled:
                      selectedIndustryId == null || selectedJobId == null,
                ),
                SizedBox(height: height * .05),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
