import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../models/job_post.dart';
import '../../../../providers/job_posts_provider.dart';
import '../../../../utils/styles/theme_colors.dart';
import 'show_search_button.dart';

enum SalaryPeriod { hourly, daily, monthly, yearly }

class CompensationAndContractPage extends StatefulWidget {
  CompensationAndContractPage({Key? key}) : super(key: key);

  @override
  _CompensationAndContractPageState createState() =>
      _CompensationAndContractPageState();
}

class _CompensationAndContractPageState
    extends State<CompensationAndContractPage> {
  JobType? _selectedJobType;
  SalaryPeriod? _selectedSalaryPeriod;
  int? _durationInMonth;
  DateTime? _startDate;
  DateTime? _endDate;
  TextEditingController _salaryController = TextEditingController();

  Future<void> _selectDate(BuildContext context,
      {bool isStartDate = true}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Compensation & Contract",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<JobType>(
                value: _selectedJobType,
                items: JobType.values.map((JobType type) {
                  return DropdownMenuItem<JobType>(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  );
                }).toList(),
                hint: Text("Select a Job Type"),
                onChanged: (JobType? newValue) {
                  setState(() {
                    _selectedJobType = newValue;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              if (_selectedJobType == JobType.contract) ...[
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) => _durationInMonth = int.tryParse(value),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Duration in Month",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                )
              ],
              if (_selectedJobType == JobType.specifiedTime) ...[
                const SizedBox(height: 20),
                showSearchButton(
                  context: context,
                  title: _startDate == null
                      ? "Select Start Date"
                      : "Start Date: ${DateFormat('EEEE, d MMMM, y').format(_startDate!)}",
                  onPressed: () => _selectDate(context),
                ),
                const SizedBox(height: 20),
                showSearchButton(
                  context: context,
                  title: _endDate == null
                      ? "Select End Date"
                      : "End Date: ${DateFormat('EEEE, d MMMM, y').format(_endDate!)}",
                  onPressed: () => _selectDate(context, isStartDate: false),
                ),
              ],
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _salaryController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Salary Amount",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<SalaryPeriod>(
                      value: _selectedSalaryPeriod,
                      items: SalaryPeriod.values.map((SalaryPeriod period) {
                        return DropdownMenuItem<SalaryPeriod>(
                          value: period,
                          child: Text(period.toString().split('.').last),
                        );
                      }).toList(),
                      hint: Text("Select Salary Period"),
                      onChanged: (SalaryPeriod? newValue) {
                        setState(() {
                          _selectedSalaryPeriod = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      jp.setJobPostPagePrevious();
                    },
                    child: const Text("Previous"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ThemeColors.secondaryThemeColor),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      jp.addCompensationAndContract(
                        jobType: _selectedJobType,
                        salaryAmount: _salaryController.text,
                        salaryPeriod: _selectedSalaryPeriod,
                        durationInMonth: _durationInMonth,
                        startDate: _startDate,
                        endDate: _endDate,
                      );
                    },
                    child: const Text("Next"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ThemeColors.secondaryThemeColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * .05),
            ],
          ),
        ),
      ),
    );
  }
}
