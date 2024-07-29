import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/worker_provider.dart';
import '../../../../../../services/responsive.dart';
import '../../../../old_common_views/skills_form/skills_form.dart';
import '../credential_field.dart';
import '../timeline_navigation_button.dart';

class ProfessionalCredentialsPage extends StatefulWidget {
  const ProfessionalCredentialsPage({super.key});

  @override
  _ProfessionalCredentialsPageState createState() =>
      _ProfessionalCredentialsPageState();
}

class _ProfessionalCredentialsPageState
    extends State<ProfessionalCredentialsPage> {
  late WorkerProvider wp;
  List<String> selectedSkills = [];
  List<CredentialField> credentialForms = [];

  @override
  void initState() {
    super.initState();
    wp = Provider.of<WorkerProvider>(context, listen: false);
    selectedSkills = wp.previousParams['skills'] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    credentialForms = [];
    for (int i = 0; i < wp.professionalCredentials.length; i++) {
      credentialForms.add(CredentialField(index: i));
    }
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),

            // Qualification and Certification Label
            Text(
              AppLocalizations.of(context)!.certification,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 10),
            ...credentialForms,

            Align(
              alignment: Alignment.centerRight,
              child: Tooltip(
                message: AppLocalizations.of(context)!.addMoreCertifications,
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      wp.addCredential();
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.grey[400]),
            const SizedBox(height: 20),
            SkillsForm(selectedSkills: selectedSkills),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimelineNavigationButton(
                  isSelected: true,
                  onPress: () {
                    wp.workerProfileBackPage();
                  },
                  navDirection: "back",
                ),
                TimelineNavigationButton(
                  isSelected: true,
                  onPress: () {
                    wp.setSkills(selectedSkills);
                  },
                ),
              ],
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
