import 'package:bulkers/models/address.dart';
import 'package:bulkers/views/common_views/info_display_component.dart';
import 'package:bulkers/views/common_views/info_display_list_component.dart';
import 'package:bulkers/views/common_views/profile_dialog.dart';
import 'package:bulkers/views/company/profile_components/edit_company_basic_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CompanyBasicProfileDetail extends StatelessWidget {
  const CompanyBasicProfileDetail(
      {super.key,
      required this.name,
      this.companyDescription,
      required this.emails,
      required this.phoneNumbers,
      required this.onPressEditIcon,
      this.addresses});
  final String name;
  final String? companyDescription;
  final List<String> emails;
  final List<String> phoneNumbers;
  final List<Address>? addresses;
  final VoidCallback onPressEditIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   "Basic Information",
        //   style:
        //       ThemeTextStyles.headingThemeTextStyle.apply(color: Colors.black),
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        InfoDisplayComponent(
          placeHolder: "Display Name",
          value: name,
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                  child: EditCompanyBasicInfo(
                    placeHolder: "Name",
                    value: name,
                    //   values: company.emails,//["+92-317 7936365"],
                    // isPhoneNumber: true,
                  ),
                ),
              );
            },
            child: Icon(
              Icons.edit_outlined,
              color: Colors.grey[700],
              size: 30,
            ),
          ),
        ),
        InfoDisplayListComponent(
          placeHolder: "Email",
          value: emails,
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                  child: EditCompanyBasicInfo(
                    placeHolder: "Emails",
                    //value: name,
                    values: emails, //["+92-317 7936365"],
                    // isPhoneNumber: true,
                  ),
                ),
              );
            },
            child: Icon(
              Icons.edit_outlined,
              color: Colors.grey[700],
              size: 30,
            ),
          ),
        ),
        InfoDisplayListComponent(
          placeHolder: "Phone No",
          value: phoneNumbers,
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                  child: EditCompanyBasicInfo(
                    placeHolder: "Emails",
                    //value: name,
                    values: ["+92-317 7936365"],
                     isPhoneNumber: true,
                  ),
                ),
              );
            },
            child: Icon(
              Icons.edit_outlined,
              color: Colors.grey[700],
              size: 30,
            ),
          ),
        ),
        InfoDisplayComponent(
          placeHolder: "Description",
          value: companyDescription!,
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                  child: EditCompanyBasicInfo(
                    placeHolder: "Description",
                    value: companyDescription,
                    //   values: company.emails,//["+92-317 7936365"],
                    // isPhoneNumber: true,
                  ),
                ),
              );
            },
            child: Icon(
              Icons.edit_outlined,
              color: Colors.grey[700],
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
