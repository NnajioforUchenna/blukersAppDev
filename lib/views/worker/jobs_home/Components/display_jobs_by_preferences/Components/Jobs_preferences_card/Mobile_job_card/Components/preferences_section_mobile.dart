// preferences_section_mobile.dart

import 'package:flutter/material.dart';
import 'package:blukers/models/industry.dart';
import 'package:provider/provider.dart';
import 'package:blukers/providers/industry_provider.dart';

class PreferencesSectionMobile extends StatelessWidget {
  final List<String> selectedIndustries;
  final Map<String, List<String>> selectedJobs;
  final bool isExpanded;
  final Function(bool) onExpandedChange;
  final VoidCallback onPreferencesUpdated;

  const PreferencesSectionMobile({
    Key? key,
    required this.selectedIndustries,
    required this.selectedJobs,
    required this.isExpanded,
    required this.onExpandedChange,
    required this.onPreferencesUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final industries = Provider.of<IndustriesProvider>(context).industries.values.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                            label: Text(job, style: const TextStyle(fontSize: 12)),
                            deleteIcon: const Icon(Icons.close, size: 14),
                            onDeleted: () {
                              selectedJobs[entry.key]?.remove(job);
                              if (selectedJobs[entry.key]?.isEmpty ?? true) {
                                selectedJobs.remove(entry.key);
                                selectedIndustries.remove(entry.key);
                              }
                              onPreferencesUpdated();
                            },
                          ),
                        );
                      }).toList();
                    }).toList(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => onExpandedChange(!isExpanded),
                child: Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (isExpanded)
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
                children: industries.map((industry) {
                  bool isSelected = selectedIndustries.contains(industry.industryId);
                  return Column(
                    children: [
                      CheckboxListTile(
                        title: Text(
                          industry.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.orange : Colors.black,
                          ),
                        ),
                        value: isSelected,
                        onChanged: (bool? value) {
                          if (value == true) {
                            selectedIndustries.add(industry.industryId);
                          } else {
                            selectedIndustries.remove(industry.industryId);
                            selectedJobs.remove(industry.industryId);
                          }
                          onPreferencesUpdated();
                        },
                      ),
                      if (isSelected)
                        ...industry.jobs.entries.map((entry) {
                          final jobId = entry.value.title;
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: CheckboxListTile(
                              title: Text(
                                jobId,
                                style: TextStyle(
                                  color: Colors.blueGrey[700],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              value: selectedJobs[industry.industryId]?.contains(jobId) ?? false,
                              onChanged: (bool? value) {
                                if (!selectedJobs.containsKey(industry.industryId)) {
                                  selectedJobs[industry.industryId] = [];
                                }
                                if (value == true) {
                                  selectedJobs[industry.industryId]!.add(jobId);
                                } else {
                                  selectedJobs[industry.industryId]!.remove(jobId);
                                  if (selectedJobs[industry.industryId]!.isEmpty) {
                                    selectedJobs.remove(industry.industryId);
                                    selectedIndustries.remove(industry.industryId);
                                  }
                                }
                                onPreferencesUpdated();
                              },
                            ),
                          );
                        }).toList(),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}
