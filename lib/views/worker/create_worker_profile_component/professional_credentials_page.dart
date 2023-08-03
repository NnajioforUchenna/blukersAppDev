import 'package:bulkers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/styles/theme_colors.dart';
import 'credential_field.dart';

class ProfessionalCredentialsPage extends StatefulWidget {
  @override
  _ProfessionalCredentialsPageState createState() =>
      _ProfessionalCredentialsPageState();
}

class _ProfessionalCredentialsPageState
    extends State<ProfessionalCredentialsPage> {
  List<CredentialField> credentialControllers = [const CredentialField()];
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

  void _addCredentialField() {
    setState(() {
      credentialControllers.add(const CredentialField());
    });
  }

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Professional Credentials",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: 25,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 20),

            // Qualification and Certification Label
            const Text(
              "Qualification and Certification",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 10),

            ...List.generate(credentialControllers.length, (index) {
              return Column(
                children: [
                  const CredentialField(),
                  const SizedBox(height: 10),
                  if (index == credentialControllers.length - 1)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Tooltip(
                        message: "Add more credentials",
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _addCredentialField();
                            });
                          },
                        ),
                      ),
                    ),
                ],
              );
            }),

            Divider(thickness: 1, color: Colors.grey[400]),

            const SizedBox(height: 20),

            // Skills Section
            const Text(
              "Select Skills",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: skills.map((skill) {
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle "previous" logic here
                  },
                  child: const Text("Previous"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ThemeColors.secondaryThemeColor),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle "submit" or "next" logic here
                    wp.workerProfileNextPage();
                  },
                  child: const Text("Next"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ThemeColors.secondaryThemeColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
