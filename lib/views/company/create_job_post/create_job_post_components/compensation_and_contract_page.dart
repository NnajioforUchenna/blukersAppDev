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

  // Validate if all required fields are filled
  bool _isFormValid() {
    return _selectedJobType != null &&
        _selectedSalaryPeriod != null &&
        _salaryController.text.isNotEmpty &&
        (_selectedJobType != JobType.contract || _durationInMonth != null) &&
        !(_selectedJobType == JobType.specifiedTime && (_startDate == null || _endDate == null));
  }

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => jp.setJobPostPagePrevious(),
        ),
        title: Text(
          AppLocalizations.of(context)!.createJobPost,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 70),
              _buildJobTypeDropdown(),
              if (_selectedJobType == JobType.contract) _buildDurationField(),
              if (_selectedJobType == JobType.specifiedTime) ...[
                const SizedBox(height: 40),
                _buildDateField('Start Date', _startDate, true),
                const SizedBox(height: 40),
                _buildDateField('End Date', _endDate, false),
              ],
              const SizedBox(height: 40),
              _buildSalaryField(),
               const SizedBox(height: 20),
              _buildSalaryPeriodDropdown(),
              const SizedBox(height: 100), // Adjust as needed
              _buildNavigationButtons(jp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.selectAJobType,
          style: const TextStyle(
            color: Colors.deepOrange,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.30,
          height: 52,
          child: DropdownButtonFormField<JobType>(
            value: _selectedJobType,
            items: JobType.values.map((JobType type) {
              return DropdownMenuItem<JobType>(
                value: type,
                child: Text(
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
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDurationField() {
    return TextField(
      onChanged: (value) => _durationInMonth = int.tryParse(value),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Duration in Month",
        contentPadding: const EdgeInsets.fromLTRB(12, 20, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }

  Widget _buildDateField(String title, DateTime? date, bool isStartDate) {
    return showSearchButton(
      context: context,
      title: date == null
          ? "Select $title"
          : "$title: ${DateFormat('EEEE, d MMMM, y').format(date)}",
      onPressed: () => _selectDate(context, isStartDate: isStartDate),
    );
  }

  Widget _buildSalaryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${AppLocalizations.of(context)!.salaryAmount} (In USD)",
          style: const TextStyle(
            color: Colors.deepOrange,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            height: 80, // Increased height
            child: TextField(
              controller: _salaryController,
              decoration: InputDecoration(
                hintText: 'Enter salary amount', // This is the placeholder text
                contentPadding: const EdgeInsets.fromLTRB(
                    12, 16, 0, 0), // Adjust padding as needed
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(
                    r'^\d+\.?\d*')), // Allows numbers and a single decimal point
              ],
            )),
      ],
    );
  }

  Widget _buildSalaryPeriodDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.selectSalaryPeriod,
          style: const TextStyle(
            color: Colors.deepOrange,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.30,
          height: 52,
          child: DropdownButtonFormField<SalaryPeriod>(
            value: _selectedSalaryPeriod,
            items: SalaryPeriod.values.map((SalaryPeriod period) {
              return DropdownMenuItem<SalaryPeriod>(
                value: period,
                child: Text(
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
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(JobPostsProvider jp) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: ElevatedButton(
            onPressed: () => jp.setJobPostPagePrevious(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Background color
              padding: const EdgeInsets.symmetric(
                  horizontal: 80, vertical: 20), // Increased padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              side: const BorderSide(
                color: Colors.deepOrange, // Border color
                width: 1.0, // Border width
              ),
            ),
            child: FittedBox(
              child: Text(
                AppLocalizations.of(context)!.previous, // Text for the button
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 16, // Increased font size
                  fontWeight: FontWeight.w600, // Font weight
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 50),
        Flexible(
          child: ElevatedButton(
            onPressed: () {
              if (_isFormValid()) {
                jp.addCompensationAndContract(
                  jobType: _selectedJobType,
                  salaryAmount: _salaryController.text,
                  salaryPeriod: _selectedSalaryPeriod,
                  durationInMonth: _durationInMonth,
                  startDate: _startDate,
                  endDate: _endDate,
                );
                // Navigate to the next page or perform other actions
              } else {
                // Show a message to the user indicating that the form is not valid
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(" please fill all required fields"),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange, // Background color
              padding: const EdgeInsets.symmetric(
                  horizontal: 80, vertical: 20), // Increased padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
            ),
            child: FittedBox(
              child: Text(
                AppLocalizations.of(context)!.next, // Text for the button
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16, // Increased font size
                  fontWeight: FontWeight.w600, // Font weight
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
