import 'package:blukers/models/company.dart';
import 'package:blukers/views/common_views/info_display_component.dart';
import 'package:blukers/views/common_views/profile_dialog.dart';
import 'package:blukers/views/company/profile_components/edit_company_basic_info.dart';
import 'package:flutter/material.dart';

import '../../common_views/select_industry_components/industry_jobs_dropdown.dart';

class CompanyAdditionalProfileDetail extends StatelessWidget {
  const CompanyAdditionalProfileDetail(
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
          placeHolder: "Year Founded",
          value:
              company.yearFounded != null ? company.yearFounded.toString() : "",
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                  child: EditCompanyBasicInfo(
                    placeHolder: "Year Founded",
                    textInputType: TextInputType.number,
                    value: company.yearFounded != null
                        ? company.yearFounded.toString()
                        : "",
                    onPressUpdate: (value, values) {
                      print(value);
                      company.yearFounded = int.parse(value!);
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
        // InfoDisplayListComponent(
        //   placeHolder: "Email",
        //   value: company.emails,
        //   icon: GestureDetector(
        //     onTap: () {
        //       print("Edit clicked");
        //       showDialog(
        //         context: context,
        //         builder: (context) => ProfileDialog(
        //           child: EditCompanyBasicInfo(
        //             placeHolder: "Emails",
        //             //value: name,
        //             values: company.emails, //["+92-317 7936365"],
        //             onPressUpdate: (value, values) {
        //               print(values);
        //               company.emails = values!;
        //               onPressUpdate(company);
        //             },
        //             // isPhoneNumber: true,
        //           ),
        //         ),
        //       );
        //     },
        //     child: Icon(
        //       Icons.edit_outlined,
        //       color: Colors.grey[700],
        //       size: 30,
        //     ),
        //   ),
        // ),
        // InfoDisplayListComponent(
        //   placeHolder: "Phone No",
        //   value: company.phoneNumbers,
        //   icon: GestureDetector(
        //     onTap: () {
        //       print("Edit clicked");
        //       showDialog(
        //         context: context,
        //         builder: (context) => ProfileDialog(
        //           child: EditCompanyBasicInfo(
        //             placeHolder: "Phone Numbers",
        //             //value: name,
        //             values: company.phoneNumbers,
        //             isPhoneNumber: true,
        //             onPressUpdate: (value, values) {
        //               print(values);
        //               company.phoneNumbers = values!;
        //               onPressUpdate(company);
        //             },
        //           ),
        //         ),
        //       );
        //     },
        //     child: Icon(
        //       Icons.edit_outlined,
        //       color: Colors.grey[700],
        //       size: 30,
        //     ),
        //   ),
        // ),
        InfoDisplayComponent(
          placeHolder: "No of Employees",
          value: company.totalEmployees != null
              ? company.totalEmployees.toString()
              : "",
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                  child: EditCompanyBasicInfo(
                    placeHolder: "No of Employees",
                    textInputType: TextInputType.number,
                    value: company.totalEmployees != null
                        ? company.totalEmployees.toString()
                        : "",
                    onPressUpdate: (value, values) {
                      company.totalEmployees = int.parse(value!);
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
        InfoDisplayComponent(
          placeHolder: "Industires / Jobs",
          value:
              "Industries: ${company.industryIds != null ? company.industryIds!.join(", ") : ""}\n\nJobs: ${company.jobPostIds != null ? company.jobPostIds!.join(", ") : ""}",
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                    child: IndustryJobsDropdownComponent(
                  initialIndustries: company.industryIds ?? [],
                  initialJobs: company.jobPostIds ?? [],
                  onPressUpdate: (selectedIndustries, selectedJobs) {
                    print(selectedIndustries);
                    company.industryIds = selectedIndustries;
                    company.jobPostIds = selectedJobs;
                    onPressUpdate(company);
                  },
                )
                    // EditCompanyBasicInfo(
                    //   placeHolder: "Year Founded",
                    //   textInputType: TextInputType.number,
                    //   value: company.yearFounded != null
                    //       ? company.yearFounded.toString()
                    //       : "",
                    //   onPressUpdate: (value, values) {
                    //     print(value);
                    //     company.yearFounded = int.parse(value!);
                    //     onPressUpdate(company);
                    //   },
                    //   //   values: company.emails,//["+92-317 7936365"],
                    //   // isPhoneNumber: true,
                    // ),
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
