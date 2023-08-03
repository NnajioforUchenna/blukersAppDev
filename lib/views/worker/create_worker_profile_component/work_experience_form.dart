import 'package:bulkers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'work_experience_date.dart';
import 'work_experience_location_form.dart';

class WorkExperienceForm extends StatelessWidget {
  final int index;
  WorkExperienceForm({Key? key, required this.index}) : super(key: key);

  final TextEditingController _companyNameController = TextEditingController();

  final TextEditingController _jobTitleController = TextEditingController();

  final TextEditingController _jobDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            AuthInput(
              child: Text(
                "Work Experience ${index + 1}",
                textAlign: TextAlign.center,
                style: GoogleFonts.ebGaramond(
                  color: Colors.deepOrangeAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            AuthInput(
              child: TextFormField(
                controller: _companyNameController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                validator: (value) => value!.isEmpty ? "Required" : null,
                onChanged: (value) {
                  wp.workExperience[index]['companyName'] = value;
                },
                decoration: InputDecoration(
                  hintText: "Company Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AuthInput(
              child: TextFormField(
                controller: _jobTitleController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                validator: (value) => value!.isEmpty ? "Required" : null,
                onChanged: (value) {
                  wp.workExperience[index]['jobTitle'] = value;
                },
                decoration: InputDecoration(
                  hintText: "Job Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AuthInput(
              child: TextFormField(
                maxLines: 3,
                controller: _jobDescriptionController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                validator: (value) => value!.isEmpty ? "Required" : null,
                onChanged: (value) {
                  wp.workExperience[index]['jobDescription'] = value;
                },
                decoration: InputDecoration(
                  hintText: "Job Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            WorkExperienceLocationForm(
              intialIndex: index,
            ),
            const SizedBox(height: 10),
            WorkExperienceDate(
              intialIndex: index,
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.deepOrangeAccent,
            ),
          ],
        ),
      ),
    );
  }
}
