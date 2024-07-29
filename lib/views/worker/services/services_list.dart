import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common_files/constants.dart';
import '../../../providers/app_settings_provider.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import 'services_components/service_card.dart';

class ServicesList extends StatelessWidget {
  const ServicesList({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettingsProvider avp = Provider.of<AppSettingsProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    String? userRole = up.userRole;

    String getTitle(serviceTitle) {
      if (serviceTitle == "Subscriptions") {
        return AppLocalizations.of(context)!.subscriptions;
      }
      if (serviceTitle == "Products") {
        return AppLocalizations.of(context)!.products;
      }
      return "";
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50.0, bottom: 10.0),
            child: Text(
              AppLocalizations.of(context)!.services,
              style: GoogleFonts.montserrat(
                fontSize: 20.0,
                // fontWeight: FontWeight.bold,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                for (var service in listServices)
                  ServiceCard(
                    // title: service['title']!,
                    title: getTitle(service['title']!),
                    description: service['description']!,
                    route: service['route']!,
                    service: service['service']!,
                    color: service['color'],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
