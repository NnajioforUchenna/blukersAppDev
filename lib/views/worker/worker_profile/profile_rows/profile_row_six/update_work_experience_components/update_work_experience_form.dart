import '../../../../../../providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'update_work_experience_date.dart';
import 'update_work_experience_location_form.dart';

class UpdateWorkExperienceForm extends StatefulWidget {
  final int index;
  const UpdateWorkExperienceForm({super.key, required this.index});

  @override
  State<UpdateWorkExperienceForm> createState() =>
      _UpdateWorkExperienceFormState();
}

class _UpdateWorkExperienceFormState extends State<UpdateWorkExperienceForm> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Check if the widget is still in the tree
        UserProvider up = Provider.of<UserProvider>(context, listen: false);

        if (up.workExperiences[widget.index]['companyName'] != null) {
          _companyNameController.text =
              up.workExperiences[widget.index]['companyName'] ?? '';
        }
        if (up.workExperiences[widget.index]['jobTitle'] != null) {
          _jobTitleController.text =
              up.workExperiences[widget.index]['jobTitle'] ?? '';
        }
        if (up.workExperiences[widget.index]['jobDescription'] != null) {
          _jobDescriptionController.text =
              up.workExperiences[widget.index]['jobDescription'] ?? '';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    UserProvider up = Provider.of<UserProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Experience #${widget.index + 1}",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.deepOrangeAccent,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            TextInputWigdet(
              label: AppLocalizations.of(context)!.companyName,
              maxlines: 1,
              controller: _companyNameController,
              onChanged: (value) {
                up.workExperiences[widget.index]['companyName'] = value;
              },
            ),
            const SizedBox(height: 7),
            TextInputWigdet(
              label: AppLocalizations.of(context)!.jobTitle,
              maxlines: 1,
              controller: _jobTitleController,
              onChanged: (value) {
                up.workExperiences[widget.index]['jobTitle'] = value; 
              },
            ),
            const SizedBox(height: 7),
            TextInputWigdet(
              label: AppLocalizations.of(context)!.jobDescription,
              maxlines: 2,
              controller: _jobDescriptionController,
              onChanged: (value) {
                up.workExperiences[widget.index]['jobDescription'] = value;
              },
            ),
            const SizedBox(height: 15),
            UpdateWorkExperienceLocationForm(
              intialIndex: widget.index,
            ),
            const SizedBox(height: 10),
            UpdateWorkExperienceDate(
              intialIndex: widget.index,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  TextInputWigdet(
      {required String label,
      required int maxlines,
      required TextEditingController controller,
      required Null Function(dynamic value) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: (value) =>
              value!.isEmpty ? AppLocalizations.of(context)!.required : null,
          onChanged: onChanged,
          maxLines: maxlines,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        )
      ],
    );
  }
}
