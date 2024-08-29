import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    CreateWorkerProfileProvider cwpp =
        Provider.of<CreateWorkerProfileProvider>(context);
    cwpp.credentialForms = [];
    for (int i = 0; i < cwpp.professionalCredentials.length; i++) {
      cwpp.credentialForms.add(CredentialField(index: i));
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
            ...cwpp.credentialForms,

            Align(
              alignment: Alignment.centerRight,
              child: Tooltip(
                message: AppLocalizations.of(context)!.addMoreCertifications,
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      cwpp.addCredential();
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.grey[400]),
            const SizedBox(height: 20),
            SkillsForm(selectedSkills: cwpp.selectedSkills),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimelineNavigationButton(
                  isSelected: true,
                  onPress: () {
                    cwpp.workerProfileBackPage();
                  },
                  navDirection: "back",
                ),
                TimelineNavigationButton(
                  isSelected: true,
                  onPress: () {
                    FocusScope.of(context).unfocus();
                    cwpp.setSkills(cwpp.selectedSkills);
                    ;
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
