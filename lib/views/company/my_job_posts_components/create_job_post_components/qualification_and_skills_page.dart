import 'package:bulkers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_posts_provider.dart';

class QualificationAndSkillsPage extends StatefulWidget {
  QualificationAndSkillsPage({Key? key}) : super(key: key);

  @override
  _QualificationAndSkillsPageState createState() =>
      _QualificationAndSkillsPageState();
}

class _QualificationAndSkillsPageState
    extends State<QualificationAndSkillsPage> {
  final _requirementsController = TextEditingController();
  List<String> skills = [
    'Python',
    'Flutter',
    'Dart',
    'React',
    'Angular',
    'Vue',
    'JavaScript'
  ];
  List<String> selectedSkills = [];

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
              const Text("Select Skills",
                  textAlign: TextAlign.center,
                  style: ThemeTextStyles.landingPageBtnThemeTextStyle),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: skills.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String skill = entry.value;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(
                      label: Text(skill),
                      selected: selectedSkills.contains(skill),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedSkills.add(skill);
                          } else {
                            selectedSkills.remove(skill);
                          }
                        });
                      },
                      backgroundColor: Colors.lightBlue[100],
                      selectedColor: Colors.blue[700],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
              SizedBox(height: height * 0.02),
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
