import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_posts_provider.dart';
import '../../../old_common_views/skills_form/skills_form.dart';
import '../../../worker/worker_profile/create_worker_profile/create_worker_profile_components/timeline_navigation_button.dart';

class QualificationAndSkillsPage extends StatefulWidget {
  const QualificationAndSkillsPage({super.key});

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
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              TextField(
                controller: _requirementsController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.requirements,
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
                  TimelineNavigationButton(
                    isSelected: true,
                    onPress: () => jp.setJobPostPagePrevious(),
                    navDirection: "back",
                  ),
                  TimelineNavigationButton(
                    isSelected: true,
                    onPress: () {
                      jp.addQualificationAndSkills(
                        _requirementsController.text,
                        selectedSkills,
                      );
                    },
                  ),
                ],
              ),
              // SizedBox(height: height * .05),
              const SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}
