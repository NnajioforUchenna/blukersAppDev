import 'package:blukers/models/worker.dart';
import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/common_views/info_edit_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class EditWorkerBasicProfile extends StatefulWidget {
  const EditWorkerBasicProfile({
    super.key,
  });

  @override
  State<EditWorkerBasicProfile> createState() => _EditBasicProfileState();
}

class _EditBasicProfileState extends State<EditWorkerBasicProfile> {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    Worker worker = up.appUser!.worker!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.basicInformation,
          style:
              ThemeTextStyles.headingThemeTextStyle.apply(color: Colors.black),
        ),
        Text(
          AppLocalizations.of(context)!.edit,
          style:
              ThemeTextStyles.headingThemeTextStyle.apply(color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        InfoEditComponent(
          placeHolder: AppLocalizations.of(context)!.firstName,
          value: worker.firstName,
          action: TextInputAction.next,
          onChangeValue: (value) {
            worker.firstName = value;
          },
        ),
        InfoEditComponent(
          placeHolder: AppLocalizations.of(context)!.middleName,
          value: worker.middleName ?? "",
          action: TextInputAction.next,
          onChangeValue: (value) {
            worker.middleName = value;
          },
          // ext: ext,
          // onChangeExtValue: (value) {
          //   ext = value;
          // },
        ),
        InfoEditComponent(
          placeHolder: AppLocalizations.of(context)!.lastName,
          value: worker.lastName,
          action: TextInputAction.done,
          onChangeValue: (value) {
            worker.lastName = value;
          },
        ),
        InfoEditComponent(
          placeHolder: AppLocalizations.of(context)!.description,
          value: worker.workerBriefDescription ?? "",
          action: TextInputAction.done,
          onChangeValue: (value) {
            worker.workerBriefDescription = value;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () async {
                await up.updateWorkerInfo(worker);
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: ThemeColors.primaryThemeColor,
                    borderRadius: BorderRadius.circular(20)),
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
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
