import 'package:bulkers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_posts_provider.dart';
import '../../../common_views/skills_form/skills_form.dart';

class QualificationAndSkillsPage extends StatefulWidget {
  QualificationAndSkillsPage({Key? key}) : super(key: key);

  @override
  _QualificationAndSkillsPageState createState() =>
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
              const Text(
                "Qualification & Skills",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _requirementsController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Requirements",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SkillsForm(
                selectedSkills: selectedSkills,
              ),
              const SizedBox(height: 40),
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
                      jp.addQualificationAndSkills(
                        _requirementsController.text,
                        selectedSkills,
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
