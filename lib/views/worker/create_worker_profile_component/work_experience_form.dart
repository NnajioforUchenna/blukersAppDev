import 'package:blukers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/common_widget/auth_input.dart';
import 'work_experience_date.dart';
import 'work_experience_location_form.dart';

class WorkExperienceForm extends StatefulWidget {
  final int index;
  WorkExperienceForm({Key? key, required this.index}) : super(key: key);

  @override
  State<WorkExperienceForm> createState() => _WorkExperienceFormState();
}

class _WorkExperienceFormState extends State<WorkExperienceForm> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  late WorkerProvider wp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (mounted) {
        // Check if the widget is still in the tree
        wp = Provider.of<WorkerProvider>(context, listen: false);
        if (wp.workExperience[widget.index]['companyName'] != null) {
          _companyNameController.text =
              wp.workExperience[widget.index]['companyName'] ?? '';
        }
        if (wp.workExperience[widget.index]['jobTitle'] != null) {
          _jobTitleController.text =
              wp.workExperience[widget.index]['jobTitle'] ?? '';
        }
        if (wp.workExperience[widget.index]['jobDescription'] != null) {
          _jobDescriptionController.text =
              wp.workExperience[widget.index]['jobDescription'] ?? '';
        }
      }
    });
  }

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
            Text(
              "Work Experience ${widget.index + 1}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: 25,
                fontWeight: FontWeight.w600,
                height: 1.25,
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
                  wp.workExperience[widget.index]['companyName'] = value;
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
                  wp.workExperience[widget.index]['jobTitle'] = value;
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
                textInputAction: TextInputAction.newline,
                onEditingComplete: () => node.nextFocus(),
                validator: (value) => value!.isEmpty ? "Required" : null,
                onChanged: (value) {
                  wp.workExperience[widget.index]['jobDescription'] = value;
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
              intialIndex: widget.index,
            ),
            const SizedBox(height: 10),
            WorkExperienceDate(
              intialIndex: widget.index,
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
