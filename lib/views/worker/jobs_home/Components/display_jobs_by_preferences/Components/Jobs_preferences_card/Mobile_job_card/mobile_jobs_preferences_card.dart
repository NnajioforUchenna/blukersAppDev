// jobs_preferences_card.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/providers/jobs_lists_provider.dart';

import 'Components/filters_section_mobile.dart';
import 'Components/preferences_section_mobile.dart';

class MobileJobsPreferencesCard extends StatefulWidget {
  const MobileJobsPreferencesCard({Key? key}) : super(key: key);

  @override
  State<MobileJobsPreferencesCard> createState() => _JobsPreferencesCardState();
}

class _JobsPreferencesCardState extends State<MobileJobsPreferencesCard> {
  bool _isExpanded = false;
  bool _isExpandedFilters = false;

  List<String> selectedIndustries = [];
  Map<String, List<String>> selectedJobs = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final up = Provider.of<UserProvider>(context, listen: false);
      final preference = up.appUser?.registrationDetails?.jobsPreference;

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
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
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
          // Job Preferences and Expandable List Section
          PreferencesSectionMobile(
            selectedIndustries: selectedIndustries,
            selectedJobs: selectedJobs,
            isExpanded: _isExpanded,
            onExpandedChange: (value) {
              setState(() {
                _isExpanded = value;
              });
            },
            onPreferencesUpdated: _updatePreferencesAndNavigate,
          ),
          const SizedBox(height: 8),

          // Filters Section
          FiltersSectionMobile(
            isExpandedFilters: _isExpandedFilters,
            onFilterExpandedChange: (value) {
              setState(() {
                _isExpandedFilters = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
