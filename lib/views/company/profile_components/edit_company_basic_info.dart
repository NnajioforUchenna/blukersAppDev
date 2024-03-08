import '../../old_common_views/InfoEditListComponent.dart';
import '../../old_common_views/info_edit_component.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../../utils/styles/theme_text_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class EditCompanyBasicInfo extends StatefulWidget {
  const EditCompanyBasicInfo(
      {super.key,
      required this.placeHolder,
      this.value,
      this.values,
      this.isPhoneNumber = false,
      required this.onPressUpdate,
      this.textInputType = TextInputType.text});
  final String placeHolder;
  final String? value;
  final List<String>? values;
  final bool isPhoneNumber;
  final Function(String? value, List<String>? values) onPressUpdate;
  final TextInputType textInputType;

  @override
  State<EditCompanyBasicInfo> createState() => _EditCompanyBasicInfoState();
}

class _EditCompanyBasicInfoState extends State<EditCompanyBasicInfo> {
  String? value;
  List<String>? values = [];
  List<String>? ext;
  @override
  void initState() {
    value = widget.value;
    if (widget.isPhoneNumber && widget.values != null) {
      ext = [];
      for (int i = 0; i < widget.values!.length; ++i) {
        List<String> extPlusNumber = widget.values![i].split("-");
        values?.add(extPlusNumber[1]);
        ext?.add(extPlusNumber[0]);
      }
    } else {
      values = widget.values;
    }
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
        if (value != null)
          InfoEditComponent(
            placeHolder: widget.placeHolder,
            value: value!,
            action: TextInputAction.next,
            textInputType: widget.textInputType,
            onChangeValue: (val) {
              value = val;
              print(val);
            },
          ),
        if (values != null)
          InfoEditListComponent(
              placeHolder: widget.placeHolder,
              value: values!,
              ext: ext,
              textInputType: widget.textInputType,
              onChangeValue: (val) {
                print(val);
                values = val;
              }),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () async {
                // await up.updateUserBasicInfo(
                //     displayName, ext, phoneNo, language);
                //   await up.updateCompanyInfo();
                widget.onPressUpdate(value, values);
                // print(value);
                //  Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(16),
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
