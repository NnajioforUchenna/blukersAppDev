import 'package:blukers/providers/industry_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../../../models/job_post.dart';
import '../../../../../../../../../providers/jobs_lists_provider.dart'; // Ensure your enums are imported correctly

class DesktopFiltersSection extends StatefulWidget {
  final bool isExpandedFilters;
  final Function(bool) onFilterExpandedChange;

  const DesktopFiltersSection({
    Key? key,
    required this.isExpandedFilters,
    required this.onFilterExpandedChange,
  }) : super(key: key);

  @override
  _DesktopFiltersSectionState createState() => _DesktopFiltersSectionState();
}

class _DesktopFiltersSectionState extends State<DesktopFiltersSection> {
  List<String> selectedIndustries = [];
  List<JobType> selectedJobTypes = [];
  JobUrgencyLevel urgencyValue = JobUrgencyLevel.medium;
  SalaryType selectedSalaryType = SalaryType.yearly;

  void clearFilters(StateSetter? dialogSetState) {
    void updateState() {
      selectedIndustries.clear();
      selectedJobTypes.clear();
      urgencyValue = JobUrgencyLevel.medium;
      selectedSalaryType = SalaryType.yearly;
    }

    setState(updateState);
    dialogSetState?.call(updateState);
  }

  bool areJobsSelected() {
    return selectedIndustries.isNotEmpty;
  }

  void _applyFilters(BuildContext dialogContext) async {
    final jlp = Provider.of<JobsListsProvider>(context, listen: false);

    if (!mounted) return;

    // Show loading indicator
    EasyLoading.show(status: 'Applying filters...');

    try {
      if (areJobsSelected()) {
        // Apply the filters
        await jlp.narrowJobsByPreferences(
          selectedIndustries: selectedIndustries,
          selectedJobTypes: selectedJobTypes,
          urgencyValue: urgencyValue,
          selectedSalaryType: selectedSalaryType,
        );
      }

      // Show success message
      EasyLoading.showSuccess('Filters applied!');

      // Close the dialog and navigate after a delay
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(dialogContext).pop(); // Close the dialog
        EasyLoading.dismiss(); // Dismiss the loading indicator
        if (mounted) {
          GoRouter.of(context).go('/jobs');
        }
      });
    } catch (e) {
      print('Error applying filters: $e');
      EasyLoading.showError('Error applying filters');
      Future.delayed(const Duration(seconds: 1), () {
        EasyLoading.dismiss();
        Navigator.of(dialogContext).pop(); // Close the dialog in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          widget.onFilterExpandedChange(!widget.isExpandedFilters);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final isMobile = MediaQuery.of(context).size.width < 900;
                if (isMobile) {
                  Navigator.of(context).pop();
                }
              });

              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Dialog(
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.55,
                          maxHeight: MediaQuery.of(context).size.height * 0.9,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFilterChips(setState),
                                    const SizedBox(height: 16),
                                    _buildFieldsOfInterest(context, setState),
                                    const SizedBox(height: 16),
                                    const Divider(),
                                    const SizedBox(height: 20),
                                    _buildJobDetails(setState),
                                    const SizedBox(height: 16),
                                    _buildCompensation(setState),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                _applyFilters(context);
                              },
                              child: const Text('Check results'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.filter_list,
                  size: 14, color: Color.fromRGBO(27, 117, 187, 1)),
              const SizedBox(width: 4),
              const Text(
                'Filters',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 4),
              Icon(
                widget.isExpandedFilters
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips(StateSetter dialogSetState) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...selectedIndustries
            .map((industry) => _buildChip(industry, dialogSetState)),
        ...selectedJobTypes
            .map((jobType) => _buildChip(jobType.name, dialogSetState)),
        _buildChip('Urgency: ${urgencyValue.name}', dialogSetState),
        _buildChip('Salary: ${selectedSalaryType.name}', dialogSetState),
        TextButton(
          onPressed: () => clearFilters(dialogSetState),
          child: const Text(
            'Cancel all',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label, StateSetter setState) {
    return Chip(
      label: Text(label),
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: () {
        setState(() {
          if (selectedIndustries.contains(label)) {
            selectedIndustries.remove(label);
          } else if (JobType.values.map((e) => e.name).contains(label)) {
            selectedJobTypes.removeWhere((type) => type.name == label);
          } else if (urgencyValue.name == label) {
            urgencyValue = JobUrgencyLevel.medium;
          } else if (selectedSalaryType.name == label) {
            selectedSalaryType = SalaryType.yearly;
          }
        });
      },
    );
  }

  Widget _buildFieldsOfInterest(BuildContext context, StateSetter setState) {
    final ip = Provider.of<IndustriesProvider>(context);
    final industries = ip.industries.values.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.search, size: 20),
            SizedBox(width: 8),
            Text(
              'Fields of interest',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildBorderedContainer(
                child: SizedBox(
                  height: 243,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Industry',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'POPULAR',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          children: industries
                              .map((industry) => _buildIndustryItem(
                                    industry.name,
                                    industryId: industry.industryId,
                                    isSelected: selectedIndustries
                                        .contains(industry.industryId),
                                    onSelected: (bool selected) {
                                      setState(() {
                                        if (selected) {
                                          selectedIndustries
                                              .add(industry.industryId);
                                        } else {
                                          selectedIndustries
                                              .remove(industry.industryId);
                                        }
                                      });
                                    },
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _buildBorderedContainer(
                child: SizedBox(
                  height: 243,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selected Industries',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: ListView(
                          children: selectedIndustries.map((industryId) {
                            final industry = industries
                                .firstWhere((i) => i.industryId == industryId);
                            return _buildIndustryItem(
                              industry.name,
                              industryId: industryId,
                              isSelected: true,
                              onSelected: (bool selected) {
                                setState(() {
                                  if (!selected) {
                                    selectedIndustries.remove(industryId);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildJobDetails(StateSetter setState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.work_outline, size: 20),
            SizedBox(width: 8),
            Text('Job details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildBorderedContainer(
                child: Container(
                  height: 243,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: JobType.values.map((type) {
                        return CheckboxListTile(
                          title: Text(
                            type.name,
                            style: TextStyle(
                              color: selectedJobTypes.contains(type)
                                  ? Colors.deepOrange
                                  : Colors
                                      .black, // Change text color based on selection
                            ),
                          ),
                          value: selectedJobTypes.contains(type),
                          onChanged: (bool? isChecked) {
                            setState(() {
                              if (isChecked == true) {
                                selectedJobTypes.add(type);
                              } else {
                                selectedJobTypes.remove(type);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _buildBorderedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Urgency level',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Slider(
                      value: JobUrgencyLevel.values
                          .indexOf(urgencyValue)
                          .toDouble(),
                      onChanged: (newValue) {
                        setState(() {
                          urgencyValue =
                              JobUrgencyLevel.values[newValue.toInt()];
                        });
                      },
                      min: 0,
                      max: JobUrgencyLevel.values.length - 1.toDouble(),
                      divisions: JobUrgencyLevel.values.length - 1,
                      label: _getUrgencyLevelLabel(urgencyValue),
                      activeColor: _getUrgencyColor(urgencyValue),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  String _getUrgencyLevelLabel(JobUrgencyLevel urgencyLevel) {
    switch (urgencyLevel) {
      case JobUrgencyLevel.low:
        return AppLocalizations.of(context)!.lowF;
      case JobUrgencyLevel.medium:
        return AppLocalizations.of(context)!.mediumF;
      case JobUrgencyLevel.high:
        return AppLocalizations.of(context)!.highF;
      default:
        return '';
    }
  }

  Color _getUrgencyColor(JobUrgencyLevel urgencyLevel) {
    switch (urgencyLevel) {
      case JobUrgencyLevel.low:
        return Colors.green;
      case JobUrgencyLevel.medium:
        return Colors.blue;
      case JobUrgencyLevel.high:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildCompensation(StateSetter setState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.attach_money, size: 20),
            SizedBox(width: 8),
            Text('Compensation',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildBorderedContainer(
                child: DropdownButton<SalaryType>(
                  value: selectedSalaryType,
                  onChanged: (SalaryType? newType) {
                    setState(() {
                      if (newType != null) {
                        selectedSalaryType = newType;
                      }
                    });
                  },
                  items: SalaryType.values
                      .map<DropdownMenuItem<SalaryType>>((SalaryType type) {
                    return DropdownMenuItem<SalaryType>(
                      value: type,
                      child: Text(type.name),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBorderedContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.zero,
      ),
      child: child,
    );
  }

  Widget _buildIndustryItem(String name,
      {required String industryId,
      required bool isSelected,
      required ValueChanged<bool> onSelected}) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(
          color: isSelected
              ? Colors.deepOrange
              : Colors.black, // Change text color based on selection
        ),
      ),
      trailing: IconButton(
        icon: Icon(isSelected ? Icons.remove : Icons.add),
        onPressed: () => onSelected(!isSelected),
      ),
    );
  }
}
