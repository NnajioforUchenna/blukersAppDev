import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'desktop_company_messages.dart';
import 'mobile_company_messages.dart';

class CompanyMessages extends StatelessWidget {
  const CompanyMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return true
        ? Center(
            child: Text(
              AppLocalizations.of(context)!.comingSoon,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 30,
              ),
            ),
          )
        : Responsive.isMobile(context)
            ? const MobileCompanyMessages()
            : const DesktopCompanyMessages();
  }
}
