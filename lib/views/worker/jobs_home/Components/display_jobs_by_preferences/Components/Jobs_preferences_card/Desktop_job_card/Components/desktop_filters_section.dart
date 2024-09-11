import 'package:blukers/providers/industry_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final industries = Provider.of<IndustriesProvider>(context).industries.values.toList();

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

              return Dialog(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.45,
                      maxHeight: MediaQuery.of(context).size.height * 0.9,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Job Search Filters',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
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
                                _buildFilterChips(),
                                const SizedBox(height: 16),
                                _buildFieldsOfInterest(context),
                                const SizedBox(height: 16),
                                _buildJobDetails(),
                                const SizedBox(height: 16),
                                _buildCompensation(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Apply filters logic here
                            Navigator.of(context).pop();
                          },
                          child: const Text('Check results'),
                          style: ElevatedButton.styleFrom(
                            iconColor: Colors.blue,
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

  Widget _buildFilterChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildChip('Driver'),
        _buildChip('Industrial truck operator'),
        _buildChip('Full time'),
        _buildChip('0-3 years'),
        TextButton(
          onPressed: () {
            // Cancel all filters
          },
          child: const Text('Cancel all', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label),
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: () {
        // Handle chip deletion
      },
    );
  }

  Widget _buildFieldsOfInterest(BuildContext context) {
    final ip = Provider.of<IndustriesProvider>(context);
    final industries = ip.industries.values.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.search, size: 20),
            const SizedBox(width: 8),
            const Text(
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
                                  isSelected: selectedIndustries.contains(industry.industryId),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        if (!selectedIndustries.contains(industry.industryId)) {
                                          selectedIndustries.add(industry.industryId);
                                        }
                                      } else {
                                        selectedIndustries.remove(industry.industryId);
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
            const SizedBox(width: 16),
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
                          children: selectedIndustries
                              .map((industryId) {
                                final industry = industries.firstWhere((i) => i.industryId == industryId);
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
                              })
                              .toList(),
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

  Widget _buildJobDetails() {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Job types',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    _buildJobTypeItem('Full time', isSelected: true),
                    _buildJobTypeItem('Part time'),
                    _buildJobTypeItem('Internship'),
                    _buildJobTypeItem('Contract'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildBorderedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Job types',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('0-3 years',
                        style: TextStyle(color: Colors.orange)),
                    Slider(
                      value: 1.5,
                      min: 0,
                      max: 3,
                      divisions: 3,
                      label: '0-3 years',
                      onChanged: (double value) {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompensation() {
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
        _buildBorderedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Salary',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('1500-2500 EUR'),
            ],
          ),
        ),
      ],
    );
  }

 Widget _buildIndustryItem(String industryName, {required String industryId, required bool isSelected, required void Function(bool) onSelected}) {
    return ListTile(
      title: Text(industryName),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.orange)
          : const Icon(Icons.radio_button_unchecked),
      onTap: () => onSelected(!isSelected),
    );
  }


  Widget _buildJobTypeItem(String jobType, {bool isSelected = false}) {
    return ListTile(
      title: Text(jobType),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.orange)
          : const Icon(Icons.radio_button_unchecked),
      onTap: () {
        // Handle job type selection
      },
    );
  }

  Widget _buildBorderedContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
