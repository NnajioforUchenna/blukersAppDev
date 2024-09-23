import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/styles/index.dart';

class WorkExperienceDate extends StatefulWidget {
  final int intialIndex;
  const WorkExperienceDate({super.key, required this.intialIndex});

  @override
  State<WorkExperienceDate> createState() => _WorkExperienceDateState();
}

class _WorkExperienceDateState extends State<WorkExperienceDate> {
  List<String> years = List.generate(101, (index) => (2000 + index).toString()); // For year selection
  List<String> months = [
    '01', '02', '03', '04', '05', '06', 
    '07', '08', '09', '10', '11', '12'
  ]; // For month selection in 'MM' format
  
  String? _selectedStartYear;
  String? _selectedStartMonth;
  String? _selectedEndYear;
  String? _selectedEndMonth;
  bool _isCurrentlyWorking = false;
  late CreateWorkerProfileProvider wp;

  @override
  void initState() {
    super.initState();
    wp = Provider.of<CreateWorkerProfileProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Assuming jobStartDate and jobEndDate are stored in the format 'YYYY-MM'
      String? jobStartDate = wp.workExperience[widget.intialIndex]['jobStartDate'];
      if (jobStartDate != null) {
        _selectedStartYear = jobStartDate.split('-')[0];
        _selectedStartMonth = jobStartDate.split('-')[1];
      }

      String? jobEndDate = wp.workExperience[widget.intialIndex]['jobEndDate'];
      if (jobEndDate != null) {
        _selectedEndYear = jobEndDate.split('-')[0];
        _selectedEndMonth = jobEndDate.split('-')[1];
      }

      _isCurrentlyWorking = wp.workExperience[widget.intialIndex]['isCurrentlyWorking'] ?? false;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    CreateWorkerProfileProvider wp = Provider.of<CreateWorkerProfileProvider>(context);

    return SizedBox(
      height: _isCurrentlyWorking ? 240 : 400,
      child: Column(
        children: [
          // Currently Working Checkbox
          Row(
            children: [
              const Spacer(),
              const Text('Are you currently working here?'),
              Expanded(
                child: Checkbox(
                  value: _isCurrentlyWorking,
                  onChanged: (bool? value) {
                    setState(() {
                      _isCurrentlyWorking = value!;
                      if (_isCurrentlyWorking) {
                        _selectedEndMonth = null;
                        _selectedEndYear = null;
                      }
                    });
                    wp.workExperience[widget.intialIndex]['isCurrentlyWorking'] = _isCurrentlyWorking;
                  },
                ),
              ),
            ],
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
             "From",
              style:TextStyle(
                color: ThemeColors.black1ThemeColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedStartMonth,
              isExpanded: true,
              decoration: InputDecoration(
                hintText: 'Month',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              items: months.map((month) => DropdownMenuItem<String>(
                value: month,
                child: Text(month),
              )).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStartMonth = value;
                  // Update the start date in 'YYYY-MM' format
                  if (_selectedStartYear != null) {
                    wp.workExperience[widget.intialIndex]['jobStartDate'] =
                        '$_selectedStartYear-$_selectedStartMonth';
                  }
                });
              },
              validator: (value) => value == null ? 'Start month is required' : null,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedStartYear,
              isExpanded: true,
              decoration: InputDecoration(
                hintText: 'Year',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              items: years.map((year) => DropdownMenuItem<String>(
                value: year,
                child: Text(year),
              )).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStartYear = value;
                  // Update the start date in 'YYYY-MM' format
                  if (_selectedStartMonth != null) {
                    wp.workExperience[widget.intialIndex]['jobStartDate'] =
                        '$_selectedStartYear-$_selectedStartMonth';
                  }
                });
              },
              validator: (value) => value == null ? 'Start year is required' : null,
            ),
          ),
          
          const SizedBox(height: 10),
          
          // End Date Selection
          Visibility(
            visible: !_isCurrentlyWorking,
            child: SizedBox(
              height: 160,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "To",
                      style:TextStyle(
                        color: ThemeColors.black1ThemeColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedEndMonth,
                      isExpanded: true,
                      decoration: InputDecoration(
                        hintText: 'Month',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(width: 1, color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      items: months.map((month) => DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      )).toList(),
                      onChanged: _isCurrentlyWorking
                          ? null
                          : (value) {
                              setState(() {
                                _selectedEndMonth = value;
                                // Update the end date in 'YYYY-MM' format
                                if (_selectedEndYear != null) {
                                  wp.workExperience[widget.intialIndex]['jobEndDate'] =
                                      '$_selectedEndYear-$_selectedEndMonth';
                                }
                              });
                            },
                      validator: (value) => !_isCurrentlyWorking && value == null
                          ? 'End month is required'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedEndYear,
                      isExpanded: true,
                      decoration: InputDecoration(
                        hintText: 'Year',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(width: 1, color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      items: years.map((year) => DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      )).toList(),
                      onChanged: _isCurrentlyWorking
                          ? null
                          : (value) {
                              setState(() {
                                _selectedEndYear = value;
                                // Update the end date in 'YYYY-MM' format
                                if (_selectedEndMonth != null) {
                                  wp.workExperience[widget.intialIndex]['jobEndDate'] =
                                      '$_selectedEndYear-$_selectedEndMonth';
                                }
                              });
                            },
                      validator: (value) => !_isCurrentlyWorking && value == null
                          ? 'End year is required'
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
