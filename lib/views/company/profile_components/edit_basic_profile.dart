import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/common_views/info_edit_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class EditBasicProfile extends StatefulWidget {
  const EditBasicProfile(
      {super.key,
      required this.displayName,
      required this.phoneNo,
      required this.language});
  final String displayName;
  final String phoneNo;
  final String language;

  @override
  State<EditBasicProfile> createState() => _EditBasicProfileState();
}

class _EditBasicProfileState extends State<EditBasicProfile> {
  String displayName = "";
  String phoneNo = "";
  String ext = "";
  String language = "";
  @override
  void initState() {
    displayName = widget.displayName;
    if (widget.phoneNo != "") {
      var extPlusPhone = widget.phoneNo.split("-");
      ext = extPlusPhone[0];
      phoneNo = extPlusPhone[1];
    }
    language = widget.language;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.editBasicInformation,
          style:
              ThemeTextStyles.headingThemeTextStyle.apply(color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        InfoEditComponent(
          placeHolder: AppLocalizations.of(context)!.displayName,
          value: displayName,
          action: TextInputAction.next,
          onChangeValue: (value) {
            displayName = value;
          },
        ),
        InfoEditComponent(
          placeHolder: AppLocalizations.of(context)!.phoneNumber,
          value: phoneNo,
          action: TextInputAction.next,
          onChangeValue: (value) {
            phoneNo = value;
          },
          ext: ext,
          onChangeExtValue: (value) {
            ext = value;
          },
        ),
        InfoEditComponent(
          placeHolder: AppLocalizations.of(context)!.language,
          value: language,
          action: TextInputAction.done,
          onChangeValue: (value) {
            language = value;
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
                print(ext + phoneNo);
                await up.updateUserBasicInfo(
                    displayName, "$ext-$phoneNo", language);
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: ThemeColors.primaryThemeColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  AppLocalizations.of(context)!.save,
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
