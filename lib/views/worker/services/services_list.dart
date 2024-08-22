import 'package:blukers/views/worker/services/services_components/show_service_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_files/constants.dart';
import '../../../services/responsive.dart';
import 'services_components/service_card.dart';

class ServicesList extends StatelessWidget {
  const ServicesList({super.key});

  String getTitle(BuildContext context, String serviceTitle) {
    switch (serviceTitle) {
      case "Subscriptions":
        return AppLocalizations.of(context)!.subscriptions;
      case "Products":
        return AppLocalizations.of(context)!.products;
      default:
        return "";
    }
  }

  Widget buildServiceCards(BuildContext context) {
    return Column(
      children: [

        for (var service in listServices)
          ServiceCard(
            title: getTitle(context, service['title']!),
            description: service['description']!,
            route: service['route']!,
            service: service['service']!,
            color: service['color'],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Ensure the Column doesn't take unbounded height
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50.0, bottom: 10.0),
            child: Text(
              AppLocalizations.of(context)!.services,
              style: GoogleFonts.montserrat(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (Responsive.isDesktop(context))
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Image.asset('assets/images/service_payments.png'),
                  ),
                  SizedBox(width: 20.sp),
                  Expanded(
                    child: buildServiceCards(context),
                  ),
                ],
              ),
            )
          else
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: buildServiceCards(context),
            ),
        ],
      ),
    );
  }
}
