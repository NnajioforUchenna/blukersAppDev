import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../timeline_navigation_button.dart';
import 'reference_form.dart';

class ReferencePage extends StatefulWidget {
  const ReferencePage({super.key});

  @override
  State<ReferencePage> createState() => _ReferencePageState();
}

class _ReferencePageState extends State<ReferencePage> {
  @override
  Widget build(BuildContext context) {
    CreateWorkerProfileProvider cwpp =
        Provider.of<CreateWorkerProfileProvider>(context);
    if (cwpp.referenceForms.isEmpty) {
      for (int i = 0; i < cwpp.references.length; i++) {
        cwpp.referenceForms.add(ReferenceFormWidget(index: i));
      }
    }
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ...cwpp.referenceForms,
            Tooltip(
              message: AppLocalizations.of(context)!.addMorePersonalReferences,
              child: InkWell(
                onTap: () {
                  cwpp.addReference();
                },
                child: Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        cwpp.addReference();
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.addMorePersonalReferences,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TimelineNavigationButton(
                    isSelected: true,
                    onPress: () => cwpp.workerProfileBackPage(),
                    navDirection: "back",
                  ),
                  TimelineNavigationButton(
                    isSelected: true,
                    onPress: () {
                      FocusScope.of(context).unfocus();

                      cwpp.setReference();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 150)
          ],
        ),
      ),
    );
  }
}
