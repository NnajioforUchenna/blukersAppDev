import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/company.dart';
import '../../old_common_views/info_display_component.dart';
import '../../old_common_views/info_display_list_component.dart';
import '../../old_common_views/profile_dialog.dart';
import 'edit_company_basic_info.dart';

class CompanyBasicProfileDetail extends StatelessWidget {
  const CompanyBasicProfileDetail(
      {super.key, required this.company, required this.onPressUpdate});

  final Company company;
  final Function(Company company) onPressUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoDisplayComponent(
          placeHolder: AppLocalizations.of(context)!.displayName,
          value: company.name,
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                  child: EditCompanyBasicInfo(
                    placeHolder: AppLocalizations.of(context)!.name,
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
          placeHolder: AppLocalizations.of(context)!.email,
          value: company.emails,
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                  child: EditCompanyBasicInfo(
                    placeHolder: AppLocalizations.of(context)!.email,
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
        // InfoDisplayListComponent(
        //   placeHolder: AppLocalizations.of(context)!.phoneNumber,
        //   value: company.phoneNumbers,
        //   icon: GestureDetector(
        //     onTap: () {
        //       print("Edit clicked");
        //       showDialog(
        //         context: context,
        //         builder: (context) => ProfileDialog(
        //           child: EditCompanyBasicInfo(
        //             placeHolder: AppLocalizations.of(context)!.phoneNumber,
        //             textInputType: TextInputType.phone,
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
          placeHolder: AppLocalizations.of(context)!.description,
          value: company.companyDescription,
          icon: GestureDetector(
            onTap: () {
              print("Edit clicked");
              showDialog(
                context: context,
                builder: (context) => ProfileDialog(
                  child: EditCompanyBasicInfo(
                    placeHolder: AppLocalizations.of(context)!.description,
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
