import 'package:bulkers/models/reference.dart';
import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/providers/worker_provider.dart';
import 'package:bulkers/utils/styles/theme_colors.dart';
import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:bulkers/views/worker/create_worker_profile_component/reference_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              .map((e) => ReferenceForm(index: wp.references.indexOf(e)))
              .toList(),
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
              List<Reference> ref = [];
              for (int i = 0; i < wp.references.length; ++i) {
                ref.add(Reference(
                    name: wp.references[i]["name"],
                    phoneNumber: wp.references[i]["phoneNumber"],
                    email: wp.references[i]["email"],
                    relationship:  wp.references[i]["relationship"]));
              }
              up.appUser!.worker!.references = ref;
              await up.updateWorkerInfo(up.appUser!.worker!);
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
                "Update",
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