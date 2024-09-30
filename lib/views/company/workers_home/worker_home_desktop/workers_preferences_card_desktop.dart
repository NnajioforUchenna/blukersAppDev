import 'package:blukers/providers/industry_provider.dart';
import 'package:blukers/providers/jobs_lists_provider.dart';
import 'package:blukers/views/worker/jobs_home/Components/display_jobs_by_preferences/Components/Jobs_preferences_card/Desktop_job_card/Components/desktop_filters_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';

class WorkersPreferencesCardDesktop extends StatefulWidget {
  const WorkersPreferencesCardDesktop({super.key});

  @override
  State<WorkersPreferencesCardDesktop> createState() =>
      _WorkersPreferencesCardDesktopState();
}

class _WorkersPreferencesCardDesktopState
    extends State<WorkersPreferencesCardDesktop> {
  bool _isExpanded = false;
  bool _isExpandedFilters = false;

  List<String> selectedIndustries = [];
  Map<String, List<String>> selectedJobs = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final up = Provider.of<UserProvider>(context, listen: false);
      final preference = up.appUser?.registrationDetails?.workersPreference;

      if (preference != null) {
        setState(() {
          selectedIndustries = preference.industryIds ?? [];
          selectedJobs = preference.jobIds ?? {};
        });
      }
    });
  }

  bool areJobsSelected() {
    return selectedIndustries.isNotEmpty && selectedJobs.isNotEmpty;
  }

  void _updatePreferencesAndNavigate() {
    final up = Provider.of<UserProvider>(context, listen: false);
    final jlp = Provider.of<JobsListsProvider>(context, listen: false);

    if (areJobsSelected()) {
      up.setJobsPreferences(selectedIndustries, selectedJobs);
      jlp.fillDisplayJobsByPreferences();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select at least one job"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .85,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Merged DesktopPreferencesSection code
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: selectedJobs.entries.expand((entry) {
                              return entry.value.map((job) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: Chip(
                                    label: Text(job,
                                        style: const TextStyle(fontSize: 12)),
                                    deleteIcon:
                                        const Icon(Icons.close, size: 14),
                                    onDeleted: () {
                                      selectedJobs[entry.key]?.remove(job);
                                      if (selectedJobs[entry.key]?.isEmpty ??
                                          true) {
                                        selectedJobs.remove(entry.key);
                                        selectedIndustries.remove(entry.key);
                                      }
                                      _updatePreferencesAndNavigate();
                                    },
                                  ),
                                );
                              }).toList();
                            }).toList(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          _isExpanded = !_isExpanded;
                        }),
                        child: Icon(
                          _isExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                if (_isExpanded)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: ip.industries.values.toList().map((industry) {
                          bool isSelected =
                              selectedIndustries.contains(industry.industryId);
                          return Column(
                            children: [
                              CheckboxListTile(
                                title: Text(
                                  industry.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.orange
                                        : Colors.black,
                                  ),
                                ),
                                value: isSelected,
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedIndustries
                                          .add(industry.industryId);
                                    } else {
                                      selectedIndustries
                                          .remove(industry.industryId);
                                      selectedJobs.remove(industry.industryId);
                                    }
                                  });
                                  _updatePreferencesAndNavigate();
                                },
                              ),
                              if (isSelected)
                                ...industry.jobs.entries.map((entry) {
                                  final jobId = entry.value.title;
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: CheckboxListTile(
                                      title: Text(
                                        jobId,
                                        style: TextStyle(
                                          color: Colors.blueGrey[700],
                                          fontSize: 20,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                      value: selectedJobs[industry.industryId]
                                              ?.contains(jobId) ??
                                          false,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (!selectedJobs.containsKey(
                                              industry.industryId)) {
                                            selectedJobs[industry.industryId] =
                                                [];
                                          }
                                          if (value == true) {
                                            selectedJobs[industry.industryId]!
                                                .add(jobId);
                                          } else {
                                            selectedJobs[industry.industryId]!
                                                .remove(jobId);
                                            if (selectedJobs[
                                                    industry.industryId]!
                                                .isEmpty) {
                                              selectedJobs
                                                  .remove(industry.industryId);
                                              selectedIndustries
                                                  .remove(industry.industryId);
                                            }
                                          }
                                        });
                                        _updatePreferencesAndNavigate();
                                      },
                                    ),
                                  );
                                }),
                              const Divider(),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),

            DesktopFiltersSection(
              isExpandedFilters: _isExpandedFilters,
              onFilterExpandedChange: (value) {
                setState(() {
                  _isExpandedFilters = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
