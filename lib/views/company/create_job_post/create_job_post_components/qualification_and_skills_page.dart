import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_posts_provider.dart';
import '../../../auth/common_widget/auth_input.dart';
import '../../../old_common_views/skills_form/skills_form.dart';
import '../../../worker/create_worker_profile/create_worker_profile_components/timeline_navigation_button.dart';

class QualificationAndSkillsPage extends StatefulWidget {
  const QualificationAndSkillsPage({super.key});

  @override
  State<QualificationAndSkillsPage> createState() =>
      _QualificationAndSkillsPageState();
}

class _QualificationAndSkillsPageState
    extends State<QualificationAndSkillsPage> {
  final _requirementsController = TextEditingController();
  List<String> selectedSkills = [];

  @override
  void initState() {
    super.initState();
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context, listen: false);
    _requirementsController.text = jp.previousParams['requirements'] ?? '';
    selectedSkills = jp.previousParams['selectedSkillNames'] ?? [];
  }

  // Method to check if the form is valid
  bool _isFormValid() {
    return _requirementsController.text.isNotEmpty && selectedSkills.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
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
        centerTitle: true, // Centers the title horizontally
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),
              Text(
                AppLocalizations.of(context)!.requirements,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 10),
              AuthInput(
                child: TextFormField(
                  maxLines: 5,
                  controller: _requirementsController,
                  textInputAction: TextInputAction.newline,
                  onEditingComplete: () => node.nextFocus(),
                  validator: (value) => value!.isEmpty
                      ? AppLocalizations.of(context)!.required
                      : null,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.requirements,
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
              const SizedBox(height: 40),
              SkillsForm(
                selectedSkills: selectedSkills,
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () => jp.setJobPostPagePrevious(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 20), // Increased padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        side: const BorderSide(
                          color: Colors.deepOrange, // Border color
                          width: 1.0, // Border width
                        ),
                      ),
                      child: FittedBox(
                        child: Text(
                          AppLocalizations.of(context)!.previous,
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
                          jp.addQualificationAndSkills(
                            _requirementsController.text,
                            selectedSkills,
                          );
                          // Navigate to the next page or perform any action here
                        } else {
                          // Show an error or alert if the form is invalid
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "please fill all fields",
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 20), // Increased padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: FittedBox(
                        child: Text(
                          AppLocalizations.of(context)!.next,
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
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
