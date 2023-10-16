import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateWorkExperienceDate extends StatefulWidget {
  final int intialIndex;
  const UpdateWorkExperienceDate({super.key, required this.intialIndex});

  @override
  State<UpdateWorkExperienceDate> createState() =>
      _UpdateWorkExperienceDateState();
}

class _UpdateWorkExperienceDateState extends State<UpdateWorkExperienceDate> {
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrentlyWorking = false;
  late UserProvider up;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      up = Provider.of<UserProvider>(context, listen: false);

      if (up.workExperiences[widget.intialIndex]['jobStartDate'] != null) {
        _startDate = DateTime.parse(
            up.workExperiences[widget.intialIndex]['jobStartDate']);
      }

      if (up.workExperiences[widget.intialIndex]['jobEndDate'] != null) {
        _endDate = DateTime.parse(
            up.workExperiences[widget.intialIndex]['jobEndDate']);
      }
      if (up.workExperiences[widget.intialIndex]['isCurrentlyWorking'] !=
          null) {
        _isCurrentlyWorking =
            up.workExperiences[widget.intialIndex]['isCurrentlyWorking'];
        setState(() {});
      }
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
          up.workExperiences[widget.intialIndex]['jobStartDate'] =
              _startDate.toString();
        } else {
          _endDate = pickedDate;
          up.workExperiences[widget.intialIndex]['jobEndDate'] =
              _endDate.toString();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
                      ? AppLocalizations.of(context)!.startDate
                      : "${DateFormat('EEEE, d MMMM, y').format(_startDate!)}"),
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
                          up.workExperiences[widget.intialIndex]
                              ['isCurrentlyWorking'] = false;
                        },
                  child: Text(_endDate == null
                      ? AppLocalizations.of(context)!.endDate
                      : " ${DateFormat('EEEE, d MMMM, y').format(_endDate!)}"),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
          child: InkWell(
            onTap: () {
              setState(() {
                _isCurrentlyWorking = !_isCurrentlyWorking;
                if (_isCurrentlyWorking) {
                  _endDate = null;
                }
              });
              up.workExperiences[widget.intialIndex]['isCurrentlyWorking'] =
                  _isCurrentlyWorking;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 0.7,
                  child: Checkbox(
                    visualDensity: VisualDensity.compact,
                    value: _isCurrentlyWorking,
                    onChanged: (bool? value) {
                      setState(() {
                        _isCurrentlyWorking = value!;
                        if (_isCurrentlyWorking) {
                          _endDate = null;
                        }
                      });
                      up.workExperiences[widget.intialIndex]
                          ['isCurrentlyWorking'] = _isCurrentlyWorking;
                    },
                  ),
                ),
                Transform.translate(
                  offset: Offset(-10.0, 0.0),
                  child: Text('currently working here',
                      style: GoogleFonts.montserrat(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
