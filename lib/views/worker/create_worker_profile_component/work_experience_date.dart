import 'package:bulkers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WorkExperienceDate extends StatefulWidget {
  final int intialIndex;
  const WorkExperienceDate({super.key, required this.intialIndex});

  @override
  State<WorkExperienceDate> createState() => _WorkExperienceDateState();
}

class _WorkExperienceDateState extends State<WorkExperienceDate> {
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrentlyWorking = false;
  late WorkerProvider wp;

  @override
  void initState() {
    super.initState();
    wp = Provider.of<WorkerProvider>(context, listen: false);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (wp.workExperience[widget.intialIndex]['jobStartDate'] != null) {
        _startDate = DateTime.parse(
            wp.workExperience[widget.intialIndex]['jobStartDate']);
      }

      if (wp.workExperience[widget.intialIndex]['jobEndDate'] != null) {
        _endDate =
            DateTime.parse(wp.workExperience[widget.intialIndex]['jobEndDate']);
      }
      _isCurrentlyWorking =
          wp.workExperience[widget.intialIndex]['isCurrentlyWorking'];
      setState(() {});
    });
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
          wp.workExperience[widget.intialIndex]['jobStartDate'] =
              _startDate.toString();
        } else {
          _endDate = pickedDate;
          wp.workExperience[widget.intialIndex]['jobEndDate'] =
              _endDate.toString();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    wp = Provider.of<WorkerProvider>(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text(_startDate == null
                      ? "Select Start Date"
                      : "Start Date: ${DateFormat('EEEE, d MMMM, y').format(_startDate!)}"),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _isCurrentlyWorking
                      ? null
                      : () {
                          _selectDate(context, isStartDate: false);
                          wp.workExperience[widget.intialIndex]
                              ['isCurrentlyWorking'] = false;
                        },
                  child: Text(_endDate == null
                      ? "Select End Date"
                      : "End Date: ${DateFormat('EEEE, d MMMM, y').format(_endDate!)}"),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Spacer(),
            const Text("Currently Working Here?"),
            Checkbox(
              value: _isCurrentlyWorking,
              onChanged: (bool? value) {
                setState(() {
                  _isCurrentlyWorking = value!;
                  if (_isCurrentlyWorking) {
                    _endDate = null;
                  }
                });

                wp.workExperience[widget.intialIndex]['isCurrentlyWorking'] =
                    _isCurrentlyWorking;
              },
            )
          ],
        ),
      ],
    );
  }
}
