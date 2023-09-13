import 'package:blukers/models/worker.dart';
import 'package:blukers/providers/user_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/common_views/info_edit_component.dart';
import 'package:flutter/material.dart';
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
          "Basic Information",
          style:
              ThemeTextStyles.headingThemeTextStyle.apply(color: Colors.black),
        ),
        Text(
          "Edit",
          style:
              ThemeTextStyles.headingThemeTextStyle.apply(color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        InfoEditComponent(
          placeHolder: "First Name",
          value: worker.firstName,
          action: TextInputAction.next,
          onChangeValue: (value) {
            worker.firstName = value;
          },
        ),
        InfoEditComponent(
          placeHolder: "Middle Name",
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
          placeHolder: "Last Name",
          value: worker.lastName,
          action: TextInputAction.done,
          onChangeValue: (value) {
            worker.lastName = value;
          },
        ),
        InfoEditComponent(
          placeHolder: "Description",
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
                  "Update",
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
