import 'package:blukers/models/industry.dart';
import 'package:blukers/providers/industry_provider.dart';
import 'package:blukers/providers/worker_provider.dart';
import 'package:blukers/utils/styles/theme_colors.dart';
import 'package:blukers/utils/styles/theme_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../models/job.dart';
import '../../../utils/localization/localized_industries.dart';
import '../../../utils/localization/localized_jobs.dart';

class IndustryJobsDropdownComponent extends StatefulWidget {
  const IndustryJobsDropdownComponent(
      {super.key,
      required this.onPressUpdate,
      required this.initialIndustries,
      required this.initialJobs});
  final List<String> initialIndustries;
  final List<String> initialJobs;

  final Function(List<String> selectedIndustries, List<String> selectedJobs)
      onPressUpdate;

  @override
  State<IndustryJobsDropdownComponent> createState() =>
      _IndustryJobsDropdownComponentState();
}

class _IndustryJobsDropdownComponentState
    extends State<IndustryJobsDropdownComponent> {
  late List<Industry> industries;
  List<String> selectedIndustries = [];
  List<String> selectedJobs = [];

  @override
  void initState() {
    selectedIndustries = widget.initialIndustries;
    selectedJobs = widget.initialJobs;
    print("asd");
    // TODO: implement initState
    super.initState();
  }

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
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    industries = ip.industries.values.toList();
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.selectYourIndustriesAndJobs,
          textAlign: TextAlign.center,
          style: const TextStyle(
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
                title: Text(
                  LocalizedIndustries.get(context, industry.industryId),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
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
                ...industry.jobs.entries.map((entry) {
                  final String jobId = entry.key;
                  final Job job = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: CheckboxListTile(
                      title: Text(
                        LocalizedJobs.get(context, jobId),
                        style: TextStyle(
                          color: Colors.blueGrey[700],
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          height: 1.25,
                        ),
                      ),
                      value: selectedJobs.contains(jobId),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedJobs.add(jobId);
                          } else {
                            selectedJobs.remove(jobId);
                          }
                        });
                        isSelect(); // Ensure this method is correctly implemented to reflect any selection changes
                      },
                    ),
                  );
                }).toList(),
            ],
          );
        }).toList(),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () async {
                // await up.updateUserBasicInfo(
                //     displayName, ext, phoneNo, language);
                //   await up.updateCompanyInfo();
                widget.onPressUpdate(selectedIndustries, selectedJobs);
                // print(value);
                //  Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: ThemeColors.primaryThemeColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Update",
                  style: ThemeTextStyles
                      .informationDisplayPlaceHolderThemeTextStyle
                      .apply(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
