import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/reference_form.dart';
import '../../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../../providers/worker_provider.dart';
import '../../../../../../utils/styles/theme_colors.dart';
import '../../../../../../utils/styles/theme_text_styles.dart';
import 'reference_form.dart';

class WorkerReferenceProfile extends StatelessWidget {
  const WorkerReferenceProfile({super.key});

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          ...wp.references
              .map((e) => ReferenceFormWidget(index: wp.references.indexOf(e))),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  wp.addNewReference();
                },
                child: Container(
                  margin: const EdgeInsets.all(12),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      color: ThemeColors.primaryThemeColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "+",
                    style: ThemeTextStyles
                        .informationDisplayPlaceHolderThemeTextStyle
                        .apply(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              List<ReferenceForm> ref = [];
              for (int i = 0; i < wp.references.length; ++i) {
                ref.add(ReferenceForm(
                    name: wp.references[i]["name"],
                    phoneNumber: wp.references[i]["phoneNumber"],
                    email: wp.references[i]["email"],
                    relationship: wp.references[i]["relationship"]));
              }
              up.appUser!.workerResumeDetails!.references = ref;

              Navigator.of(context).pop();
              print(wp.references);
            },
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                  color: ThemeColors.primaryThemeColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                AppLocalizations.of(context)!.update,
                style: ThemeTextStyles
                    .informationDisplayPlaceHolderThemeTextStyle
                    .apply(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
