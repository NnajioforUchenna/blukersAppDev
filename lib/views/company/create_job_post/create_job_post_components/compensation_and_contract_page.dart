import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../models/job_post.dart';
import '../../../../providers/job_posts_provider.dart';
import '../../../../utils/localization/localized_job_types.dart';
import '../../../../utils/localization/localized_salary_periods.dart';
import '../../../worker/create_worker_profile/create_worker_profile_components/timeline_navigation_button.dart';
import 'show_search_button.dart';

enum SalaryPeriod { hourly, daily, monthly, yearly }

class CompensationAndContractPage extends StatefulWidget {
  const CompensationAndContractPage({super.key});

  @override
  State<CompensationAndContractPage> createState() =>
      _CompensationAndContractPageState();
}

class _CompensationAndContractPageState
    extends State<CompensationAndContractPage> {
  JobType? _selectedJobType;
  SalaryPeriod? _selectedSalaryPeriod;
  int? _durationInMonth;
  DateTime? _startDate;
  DateTime? _endDate;
  final TextEditingController _salaryController = TextEditingController();

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
  void initState() {
    super.initState();
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context, listen: false);
    _selectedJobType = jp.previousParams['jobType'];
    _selectedSalaryPeriod = jp.previousParams['salaryPeriod'];
    _durationInMonth = jp.previousParams['durationInMonth'];
    _startDate = jp.previousParams['startDate'];
    _endDate = jp.previousParams['endDate'];
    _salaryController.text = jp.previousParams['salaryAmount'] ?? '';
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
              const SizedBox(height: 20),
              DropdownButtonFormField<JobType>(
                value: _selectedJobType,
                items: JobType.values.map((JobType type) {
                  return DropdownMenuItem<JobType>(
                    value: type,
                    child: Text(
                      // type.toString().split('.').last,
                      LocalizedJobTypes.get(
                        context,
                        type.toString().split('.').last,
                      ),
                    ),
                  );
                }).toList(),
                hint: Text(AppLocalizations.of(context)!.selectAJobType),
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
              TextField(
                controller: _salaryController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      r'^\d+\.?\d*')), // This allows only numbers and a single decimal point
                ],
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.salaryAmount,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<SalaryPeriod>(
                value: _selectedSalaryPeriod,
                items: SalaryPeriod.values.map((SalaryPeriod period) {
                  return DropdownMenuItem<SalaryPeriod>(
                    value: period,
                    child: Text(
                      // period.toString().split('.').last,
                      LocalizedSalaryPeriods.get(
                        context,
                        period.toString().split('.').last,
                      ),
                    ),
                  );
                }).toList(),
                hint: Text(AppLocalizations.of(context)!.selectSalaryPeriod),
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
              SizedBox(height: height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TimelineNavigationButton(
                    isSelected: true,
                    onPress: () => jp.setJobPostPagePrevious(),
                    navDirection: "back",
                  ),
                  TimelineNavigationButton(
                    isSelected: true,
                    onPress: () {
                      jp.addCompensationAndContract(
                        jobType: _selectedJobType,
                        salaryAmount: _salaryController.text,
                        salaryPeriod: _selectedSalaryPeriod,
                        durationInMonth: _durationInMonth,
                        startDate: _startDate,
                        endDate: _endDate,
                      );
                    },
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
