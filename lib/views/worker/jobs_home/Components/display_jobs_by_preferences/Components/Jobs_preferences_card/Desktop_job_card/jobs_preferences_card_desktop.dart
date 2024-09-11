// jobs_preferences_card_desktop.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/providers/industry_provider.dart';
import 'package:blukers/providers/jobs_lists_provider.dart';

import 'Components/desktop_filters_section.dart';
import 'Components/desktop_preferences_section.dart';


class JobsPreferencesCardDesktop extends StatefulWidget {
  const JobsPreferencesCardDesktop({Key? key}) : super(key: key);

  @override
  State<JobsPreferencesCardDesktop> createState() =>
      _JobsPreferencesCardDesktopState();
}

class _JobsPreferencesCardDesktopState
    extends State<JobsPreferencesCardDesktop> {
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
    UserProvider up = Provider.of<UserProvider>(context);
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1500),
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
            // Job Preferences and Expandable List Section
            DesktopPreferencesSection(
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
