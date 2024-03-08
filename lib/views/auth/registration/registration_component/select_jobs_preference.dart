import 'package:blukers/views/auth/registration/registration_component/select_jobs_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../services/responsive.dart';
import '../../common_widget/submit_button.dart';

class SelectJobsPreference extends StatefulWidget {
  const SelectJobsPreference({super.key});

  @override
  State<SelectJobsPreference> createState() => _SelectJobsPreferenceState();
}

class _SelectJobsPreferenceState extends State<SelectJobsPreference> {
  final _formKey = GlobalKey<FormState>();
  bool isValidate = true;

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Container(
        color: Colors.white,
        width: Responsive.isDesktop(context)
            ? MediaQuery.of(context).size.width * 0.3
            : MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.7),
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SelectJobsWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        SubmitButton(
                          onTap: () {
                            up.setRegisterPageIndex();
                            up.updateSelection();
                          },
                          text: AppLocalizations.of(context)!.saveProfile,
                          isDisabled: !isValidate,
                        ),
                      ],
                    ))))));
  }
}
