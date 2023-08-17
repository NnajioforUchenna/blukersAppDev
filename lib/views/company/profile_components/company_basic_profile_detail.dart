import 'package:blukers/models/address.dart';
import 'package:blukers/models/company.dart';
import 'package:blukers/views/common_views/info_display_component.dart';
import 'package:blukers/views/common_views/info_display_list_component.dart';
import 'package:blukers/views/common_views/profile_dialog.dart';
import 'package:blukers/views/company/profile_components/edit_company_basic_info.dart';
import 'package:flutter/material.dart';

class CompanyBasicProfileDetail extends StatelessWidget {
  const CompanyBasicProfileDetail(
      {super.key, required this.company, required this.onPressUpdate});
  final Company company;
  final Function(Company company) onPressUpdate;

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
          value: company.name,
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                  child: EditCompanyBasicInfo(
                    placeHolder: "Name",
                    value: company.name,
                    onPressUpdate: (value, values) {
                      print(value);
                      company.name = value!;
                      onPressUpdate(company);
                    },
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
          value: company.emails,
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                  child: EditCompanyBasicInfo(
                    placeHolder: "Emails",
                    textInputType: TextInputType.emailAddress,
                    //value: name,
                    values: company.emails, //["+92-317 7936365"],
                    onPressUpdate: (value, values) {
                      print(values);
                      company.emails = values!;
                      onPressUpdate(company);
                    },
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
          value: company.phoneNumbers,
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                  child: EditCompanyBasicInfo(
                    placeHolder: "Phone Numbers",
                    textInputType: TextInputType.phone,
                    //value: name,
                    values: company.phoneNumbers,
                    isPhoneNumber: true,
                    onPressUpdate: (value, values) {
                      print(values);
                      company.phoneNumbers = values!;
                      onPressUpdate(company);
                    },
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
          value: company.companyDescription!,
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                  child: EditCompanyBasicInfo(
                    placeHolder: "Description",
                    value: company.companyDescription,
                    onPressUpdate: (value, values) {
                      company.companyDescription = value!;
                      onPressUpdate(company);
                    },
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
