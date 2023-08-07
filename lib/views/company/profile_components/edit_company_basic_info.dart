import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/utils/styles/theme_colors.dart';
import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:bulkers/views/common_views/InfoEditListComponent.dart';
import 'package:bulkers/views/common_views/info_edit_component.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCompanyBasicInfo extends StatefulWidget {
  const EditCompanyBasicInfo(
      {super.key,
      required this.placeHolder,
      this.value,
      this.values,
      this.isPhoneNumber = false});
  final String placeHolder;
  final String? value;
  final List<String>? values;
  final bool isPhoneNumber;

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
        if (value != null)
          InfoEditComponent(
            placeHolder: widget.placeHolder,
            value: value!,
            action: TextInputAction.next,
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
              onChangeValue: (val) {
                print(val);
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
                print(value);
                //  Navigator.of(context).pop();
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
