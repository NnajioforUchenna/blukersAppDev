
import 'package:blukers/views/company/comapny_profile/components/update_company_information.dart';
import 'package:blukers/views/old_common_views/components/profile/profile_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CompanyProfileRowFive extends StatelessWidget {
  const CompanyProfileRowFive({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuButton(
      text: AppLocalizations.of(context)!.companyInformation,
      onPress: () {
        showDialog(
            context: context,
            builder: (context) => const UpdateCompanyInformation());
      },
    );
  }
}
